import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

class AppModule {
  factory AppModule() => instance;

  AppModule._();

  static final AppModule instance = AppModule._();

  String? token;
  String? email;
  String? fullname;

  void init() {
    token = '';
    email = '';
    fullname = '';
  }

  void dispose() {
    token = null;
    email = null;
    fullname = null;
  }
}

AppModule module = getIt.get<AppModule>();
