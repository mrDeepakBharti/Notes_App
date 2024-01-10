import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_notes_app_with_sqflite/DBHelper/DBHelper.dart';
import 'package:flutter_notes_app_with_sqflite/ui/Login&signup/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this);
//here i can create a instance of DBHelper class
  final db = DBHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    });
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff02084B),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
              child: Container(
                height: 200.0,
                width: 200.0,
                child: Center(
                  child: Image(image: AssetImage('assest/images/Deepak.png')),
                ),
              ),
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * 3.14159265359,
                  child: child,
                );
              }),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Notes App',
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      )),
    );
  }
}
