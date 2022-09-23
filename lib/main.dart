import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:services_worker/providers/booking_provider.dart';
import 'package:services_worker/providers/worker_provider.dart';
import 'package:services_worker/screens/splash.dart';

import 'helpers/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Plugin must be initialized before using

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const int primaryValue = 0xFF495C83;
  static MaterialColor primarySwatch = MaterialColor(
    primaryValue,
    <int, Color>{
      50: const Color(primaryValue).withOpacity(.1),
      100: const Color(primaryValue).withOpacity(.2),
      200: const Color(primaryValue).withOpacity(.3),
      300: const Color(primaryValue).withOpacity(.4),
      400: const Color(primaryValue).withOpacity(.5),
      500: const Color(primaryValue).withOpacity(.6),
      600: const Color(primaryValue).withOpacity(.7),
      700: const Color(primaryValue).withOpacity(.8),
      800: const Color(primaryValue).withOpacity(.9),
      900: const Color(primaryValue),
    },
  );
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BookingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WorkerProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: primarySwatch,
        ),
        home: const SplashScreen(),
        onGenerateRoute: RouteGenerator.onGenerateRoute,
      ),
    );
  }
}
