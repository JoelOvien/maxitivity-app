import 'package:ambeego_test/core/api/abstract_api_response.dart';
import 'package:ambeego_test/core/utils/app_module.dart';
import 'package:ambeego_test/features/auth/data/auth_datasource.dart';
import 'package:ambeego_test/features/auth/data/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDataSource extends Mock implements AuthDataSource {}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env.dev');
  group('AuthRepository', () {
    late AuthRepository authRepository;
    late _MockDataSource mockAuthDataSource;

    setUp(() {
      getIt.registerSingleton<AppModule>(AppModule());

      getIt.allowReassignment = true;
      module = getIt.get<AppModule>();

      mockAuthDataSource = _MockDataSource();
      authRepository = AuthRepository(authDataSource: mockAuthDataSource);
    });
    tearDown(() => getIt.reset());

    test('login returns Right when login is successful', () async {
      final data = {'EmailAddress': 'some@example.com', 'Password': 'password'};
      final successResponse =
          AbstractApiResponse(status: true, message: 'Success', data: {});
      when(() => mockAuthDataSource.login(data))
          .thenAnswer((_) async => successResponse);

      final result = await authRepository.login(data);

      expect(result, isA<Right<String, AbstractApiResponse>>());
      expect(result.isRight(), true);
      expect(result.getOrElse(() => successResponse), successResponse);
    });

    test('login returns Left with an error message when login fails', () async {
      final data = {'emailerr': 'sm', 'passerr': 'password'};
      final errorResponse = AbstractApiResponse(
          status: false, message: 'Unable to login user', data: null);
      when(() => mockAuthDataSource.login(data))
          .thenAnswer((_) async => errorResponse);

      final result = await authRepository.login(data);

      expect(result, isA<Left<String, AbstractApiResponse>>());
      expect(result.isLeft(), true);
    });
  });
}
