
import 'package:flutter/material.dart';
import 'package:manfred_karge/Home.dart';
import 'package:manfred_karge/intro_page.dart';
import 'package:manfred_karge/sharedpreference/store.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';


class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool showImageWidget = false;
  @override
  void initState() {
    super.initState();
    getFunction();

  }

  Future<dynamic> getFunction() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getInt("UserId");
    print("user id-----------------------------------------------------------------------" +"$store1");
    navigatorPage();

    return store1;
  }

  Future<void> navigatorPage() async {

    if (store1 == null) {
      Timer(
          Duration(seconds: 3),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => IntroPage(),
          )));
    } else {

      Timer(
          Duration(seconds: 3),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen(),
          )));
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xff081D32)
        ),
        child: Center(
          child: Image.asset("assets/image/Manfred Karger-01white.png"),
        ),

      ),
    );
  }
}


