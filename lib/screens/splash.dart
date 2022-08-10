import 'package:flutter/material.dart';
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
    // User? user = FirebaseAuth.instance.currentUser;
    // if (user == null) {
    Future.delayed(const Duration(seconds: 3)).whenComplete(() =>
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName));
    // } else {
    //   Future.delayed(const Duration(seconds: 3)).whenComplete(() =>
    //       Navigator.of(context).pushReplacementNamed(TabsScreen.routeName));
    // }
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
