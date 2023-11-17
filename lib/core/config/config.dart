import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get fileName => kDebugMode ? '.env.dev' : '.env.prod';
  static String get baseUrl => dotenv.env['BASE_URL']!;
}
