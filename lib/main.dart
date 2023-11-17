import 'package:ambeego_test/core/config/config.dart';
import 'package:ambeego_test/core/utils/app_module.dart';
import 'package:ambeego_test/core/utils/bloc_observer.dart';
import 'package:ambeego_test/features/onboarding/screens/splash.screen.dart';
import 'package:ambeego_test/providers.dart';
import 'package:ambeego_test/utilities/app_router.util.dart';
import 'package:ambeego_test/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  GoogleFonts.config.allowRuntimeFetching = true;
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  await initSingletons();
  await dotenv.load(fileName: Config.fileName);

  //Calling the App's [BlocObserver].
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

Future<void> initSingletons() async {
  getIt.registerLazySingleton<AppModule>(AppModule.new);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...providers],
      child: MaterialApp(
        title: 'Maxitivity',
        routes: AppRouter.routes,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.brandBlue500),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
