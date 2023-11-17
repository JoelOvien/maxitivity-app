import 'package:ambeego_test/core/api/abstract_api_response.dart';
import 'package:ambeego_test/core/utils/typedefs.dart';

abstract class AbstractAuthRepository {
  ResponseFormat<AbstractApiResponse> login(RequestParams<String> data);
}
