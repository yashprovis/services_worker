import 'package:flutter/material.dart';
import 'package:services_worker/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../widgets/sw_scaffold.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(tokenPref) && prefs.getString(tokenPref) != "") {
      print(prefs.getString(tokenPref));
      Future.delayed(const Duration(seconds: 3)).whenComplete(() =>
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName));
    } else {
      Future.delayed(const Duration(seconds: 3)).whenComplete(() =>
          Navigator.of(context).pushReplacementNamed(LoginScreen.routeName));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SwScaffold(
        body: Center(
      child: Hero(
          tag: "logo-shift",
          child: Image.asset(
            'assets/images/logo.png',
            color: Colors.white,
          )),
    ));
  }
}
