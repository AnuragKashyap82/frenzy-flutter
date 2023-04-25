import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_store/responsive_layout/responsive_layout_screens.dart';
import 'package:frenzy_store/screens/login_screen.dart';
import 'package:frenzy_store/screens/web_view/web_home_screen.dart';

import '../animations/fade_animation.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsLoggedIn();
  }

  checkIsLoggedIn() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          Timer(Duration(seconds: 3), () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const ResponsiveLayout(
                        webScreenLayout: WebHomeScreen(),
                        mobileScreenLayout: HomeScreen())));
          });
        });
      } else {
        Timer(Duration(seconds: 3), () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FadeAnimation(
                          1.1,
                          Container(
                              width: 280,
                              height: 280,
                              child: Icon(
                                Icons.shopping_cart_outlined,
                                size: 160,
                                color: Colors.blue,
                              ))),
                      FadeAnimation(
                          1.3,
                          Text(
                            "Frenzy Store",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5),
                          )),
                    ],
                  ),
                ),
                FadeAnimation(
                  1.4,
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "From\nAnurag Kashyap",
                      style: TextStyle(fontSize: 12, letterSpacing: 0.5),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
