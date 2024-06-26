import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_home/core/cache.dart';
import 'package:market_home/core/helper.dart';
import 'package:market_home/core/widgets.dart';
import 'package:market_home/observer.dart';
import 'package:market_home/views/auth/login/view.dart';
import 'package:market_home/views/home_nav.dart';
import 'package:market_home/views/onboarding_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  Bloc.observer = AppBlocObserver();
  await CachedData.init();

  Widget widget = const OnBoardingView();

  bool onBoarding = CachedData.getData(key: "onBoarding") ?? false;
  token = CachedData.getData(key: "token") ?? "";

  if (onBoarding) {
    if (token.isNotEmpty) {
      widget = const HomeNav();
    } else {
      widget = LoginView();
    }
  }

  runApp(
    MyApp(
      start: widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.start,
  });

  final Widget start;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[100],
        fontFamily: "BriemHand",
        platform: TargetPlatform.iOS,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[100],
          centerTitle: false,
          titleSpacing: 12,
          elevation: 0,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontFamily: "BriemHand",
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
        useMaterial3: false,
      ),
      home: start,
    );
  }
}
