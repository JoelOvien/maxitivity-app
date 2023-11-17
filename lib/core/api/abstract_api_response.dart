class AbstractApiResponse {
  AbstractApiResponse(
      {required this.status,
      required this.data,
      this.accessToken,
      this.message});

  AbstractApiResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
    accessToken = json['access_token'] ?? '';
    message = json['message'] ?? '';
  }

  bool? status;
  dynamic data;
  String? accessToken;
  String? message;
}

class Helpers {
  static AbstractApiResponse handleResponse(dynamic response) {
    return AbstractApiResponse.fromJson(response.data);
  }
}
