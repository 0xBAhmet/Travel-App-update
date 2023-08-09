import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../enum/duration.dart';

class LogoScreen extends StatefulWidget {
  const LogoScreen({super.key});

  @override
  State<LogoScreen> createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = DurationEnum.NORMAL.time;
    return new Timer(duration, loginRoute);
  }

  loginRoute() {
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: ((context) => LoginScreen())));
    GoRouter.of(context).pushReplacement('/loginScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: new Color(0xff1f3b83),
              gradient: LinearGradient(
                colors: [
                  (Color.fromARGB(255, 52, 112, 161)),
                  Color.fromARGB(255, 23, 32, 39)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("images/traworld.png"),
            )),
          )
        ],
      ),
    );
  }
}
