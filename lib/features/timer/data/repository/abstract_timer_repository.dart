import 'package:ambeego_test/core/api/abstract_api_response.dart';
import 'package:ambeego_test/core/utils/typedefs.dart';

abstract class AbstractTimerRepository {
  ResponseFormat<AbstractApiResponse> createFocusHistoryEntry(
      RequestParams<String> data);

  ResponseFormat<AbstractApiResponse> getFocusHistoryEntries(
      RequestParams<String> data);
}
