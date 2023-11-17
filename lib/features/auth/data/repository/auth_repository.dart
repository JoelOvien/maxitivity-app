import 'package:ambeego_test/core/api/abstract_api_response.dart';
import 'package:ambeego_test/core/utils/typedefs.dart';
import 'package:ambeego_test/features/auth/data/auth_datasource.dart';
import 'package:ambeego_test/features/auth/data/repository/abstract_auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepository extends AbstractAuthRepository {
  final AuthDataSource authDataSource;

  AuthRepository({
    required this.authDataSource,
  });
  @override
  ResponseFormat<AbstractApiResponse> login(RequestParams<String> data) async {
    final response = await authDataSource.login(data);

    if (response.status == true) {
      return Right(response);
    } else {
      return Left(response.message ?? 'Unable to login user');
    }
  }
}
