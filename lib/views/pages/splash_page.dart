import 'dart:async';
import 'package:bettips/views/partials/Concept1Drawer/Concept1Drawer.dart';
import 'package:bettips/views/partials/Concept1Drawer/categorylist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bettips/utils/constants.dart';
import 'package:bettips/utils/styles.dart';

//import 'home.dart';
import 'package:bettips/views/partials/Concept1Drawer/DrawerScreen.dart';

import 'intro_screen.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool(Constants.appPreviouslyRunKey) ?? false);

    if (!_seen) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => CategoryList()));
    } else {
      await prefs.setBool(Constants.appPreviouslyRunKey, true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new IntroScreenPage()));
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      checkFirstSeen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
//      decoration: BoxDecoration(
//        image: DecorationImage(
//          image: AssetImage('assets/images/football-boy.jpg'),
//          fit: BoxFit.cover,
//        ),
//      ),
      color: Colors.white, //Styles.appPrimaryColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height,
            child: Image.asset('assets/images/wineasily.png'),
          ),
        ),
      ),
    );
  }
}
