import 'package:ambeego_test/core/config/config.dart';
import 'package:ambeego_test/core/utils/app_module.dart';
import 'package:dio/dio.dart';

class ApiClient {
  ApiClient({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: Config.baseUrl,
                connectTimeout: 15000,
                headers: {
                  'Accept': 'application/json',
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer ${module.token}',
                },
              ),
            );
  final Dio _dio;

  Future<dynamic> get(String url, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: params,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${module.token}',
          },
        ),
      );
      return response;
    } on FormatException {
      throw const FormatException('Bad response format 👎');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        queryParameters: params,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${module.token}',
          },
        ),
      );
      return response;
    } on FormatException {
      throw const FormatException('Bad response format 👎');
    } catch (e) {
      rethrow;
    }
  }

  ///ADD OTHER METHODS AS NEEDED
}
