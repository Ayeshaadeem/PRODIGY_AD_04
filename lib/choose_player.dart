import 'package:flutter/material.dart';
import 'package:tic_tac_toe/player_name.dart';

class ChoosePlayerPage extends StatefulWidget {
  @override
  State<ChoosePlayerPage> createState() => _ChoosePlayerPageState();
}

class _ChoosePlayerPageState extends State<ChoosePlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 236, 236),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 10),
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 71, 160, 233),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Choose Your Mode",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Color.fromARGB(255, 71, 160, 233),
                            elevation: 6,
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NamePage(isSinglePlayer: true),
                              ),
                            );
                          },
                          child: Icon(Icons.person, size: 70),
                        )),
                  ],
                ),
                SizedBox(width: 60),
                Column(
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color.fromARGB(255, 71, 160, 233),
                          elevation: 6,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NamePage(isSinglePlayer: false),
                            ),
                          );
                        },
                        child: Icon(Icons.group, size: 70),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
