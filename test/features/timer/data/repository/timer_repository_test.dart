import 'package:ambeego_test/core/api/abstract_api_response.dart';
import 'package:ambeego_test/core/utils/app_module.dart';
import 'package:ambeego_test/features/timer/data/repository/timer_repository.dart';
import 'package:ambeego_test/features/timer/data/timer_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockTimerDataSource extends Mock implements TimerDataSource {}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env.dev');

  group('TimerRepository', () {
    late TimerRepository timerRepository;
    late _MockTimerDataSource mockTimerDataSource;

    setUp(() {
      getIt.registerSingleton<AppModule>(AppModule());

      getIt.allowReassignment = true;
      module = getIt.get<AppModule>();

      mockTimerDataSource = _MockTimerDataSource();
      timerRepository = TimerRepository(timerDataSource: mockTimerDataSource);
    });

    tearDown(() => getIt.reset());

    test('post returns Right when create is successful', () async {
      final data = {
        "start_time": "2023-11-06T15:25:21.540494+00:00",
        "end_time": "2023-11-06T15:50:21.540494+00:00",
        "email": "jovienloba1@gmail.com"
      };

      final successResponse = AbstractApiResponse(status: true, data: data);

      when(() => mockTimerDataSource.createFocusHistoryEntry(data))
          .thenAnswer((invocation) async => successResponse);

      final result = await timerRepository.createFocusHistoryEntry(data);

      expect(result, isA<Right<String, AbstractApiResponse>>());
      expect(result.fold((l) => null, (r) => r.status), true);
    });

    test('get returns Right and list when fetch is successful', () async {
      final data = {
        'email': 'jovienloba1@gmail.com',
      };

      final successResponse = AbstractApiResponse(status: true, data: [
        {
          "start_time": "2023-11-06T15:25:21.540494+00:00",
          "end_time": "2023-11-06T15:50:21.540494+00:00",
          "email": "jovienloba1@gmail.com"
        }
      ]);

      when(() => mockTimerDataSource.getFocusHistoryEntries(data))
          .thenAnswer((invocation) async => successResponse);

      final result = await timerRepository.getFocusHistoryEntries(data);

      expect(result, isA<Right<String, AbstractApiResponse>>());
      expect(result.fold((l) => null, (r) => r.data), isA<List<dynamic>>());
    });
  });
}
