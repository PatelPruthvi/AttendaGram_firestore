import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:sgp/screens/FacultyAccess.dart';
import 'package:sgp/screens/FacultyLogin.dart';
import 'package:sgp/screens/LoginMain.dart';
import 'package:sgp/screens/StudentDashboard.dart';
import 'package:sgp/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/Spl',
      routes: {
        '/': (context) => login_page(),
        '/Spl': (context) => Splash(),
        '/takea': (context) => TakeA(),
        '/faculty': (context) => faculty_login(),
      }));
}
