import 'package:bettips/views/pages/about.dart';
import 'package:bettips/views/pages/dashboard.dart';
import 'package:bettips/views/pages/flutter_tips.dart';
import 'package:bettips/views/pages/home.dart';
import 'package:bettips/views/pages/rate_app.dart';
import 'package:bettips/views/pages/refer_a_friend.dart';
import 'package:bettips/views/pages/splash_page.dart';
import 'package:bettips/views/pages/mylogin.dart';
import 'package:bettips/views/partials/Concept1Drawer/categorylist.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  '/': (context) => CategoryList(), //HomePage(),
//  '/auth': (context) => Router(),

// pages
  '/splash': (context) => SplashScreenPage(),
  '/refer-a-friend': (context) => ReferAFriendPage(),
  '/about': (context) => AboutPage(),
  '/rate-app': (context) => RateApp(),

  // auth
  '/login': (context) => LoginScreen(), //LoginPage(),
  '/dashboard': (context) => DashboardPage(),

  // backend
};
