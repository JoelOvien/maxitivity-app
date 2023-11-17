import 'package:ambeego_test/core/api/abstract_api_response.dart';
import 'package:ambeego_test/core/api/api_client.dart';
import 'package:ambeego_test/core/api/endpoints.dart';
import 'package:ambeego_test/core/utils/typedefs.dart';

class TimerDataSource {
  TimerDataSource({ApiClient? client}) : _client = client ?? ApiClient();
  final ApiClient _client;

  Future<AbstractApiResponse> createFocusHistoryEntry(
      RequestParams<String> data) async {
    final response = await _client.post(Endpoints.timer, data: data);
    final output = Helpers.handleResponse(response);
    return output;
  }

  Future<AbstractApiResponse> getFocusHistoryEntries(
      RequestParams<String> data) async {
    final url = '${Endpoints.timer}?email=${data['email']}';
    final response = await _client.get(url);
    return Helpers.handleResponse(response);
  }
}
