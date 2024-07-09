import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tic_tac_toe/choose_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FrontPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FrontPage extends StatefulWidget {
  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  void _navigateToNextPage() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChoosePlayerPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 236, 236),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Stack(children: [
      Center(
        child: Lottie.asset(
          "assets/animations/star.json",
          width: 250, height: 250, fit: BoxFit.cover,
          // repeat: falses
        ),
      ),
      Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 10),
            height: 50,
            width: 170,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 71, 160, 233),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'TIC TAC TOE',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
              .animate()
              .shimmer(delay: 400.ms, duration: 1000.ms)
              .shake(hz: 4, curve: Curves.easeInOutCubic)
              .scaleXY(end: 1.1, duration: 600.ms)
              .elevation(end: 20)
              .then(delay: 600.ms)
              .scaleXY(end: 1 / 1.1)
        ],
      ))
    ]);
  }
}
