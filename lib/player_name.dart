import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game.dart';

class NamePage extends StatefulWidget {
  final bool isSinglePlayer;

  NamePage({required this.isSinglePlayer});

  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  TextEditingController player1Controller = TextEditingController();
  TextEditingController player2Controller = TextEditingController();

  @override
  void dispose() {
    player1Controller.dispose();
    player2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 236, 236),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPlayerNameField(player1Controller, "Player 1 Name"),
            if (!widget.isSinglePlayer)
              _buildPlayerNameField(player2Controller, "Player 2 Name"),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 71, 160, 233),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                String player1Name = player1Controller.text;
                String player2Name =
                    widget.isSinglePlayer ? 'AI' : player2Controller.text;

                if (player1Name.isNotEmpty &&
                    (!widget.isSinglePlayer || player2Name.isNotEmpty)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GamePage(
                        isSinglePlayer: widget.isSinglePlayer,
                        player1Name: player1Name,
                        player2Name: player2Name,
                      ),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Color.fromARGB(255, 71, 160, 233),
                      title: Text(
                        'Incomplete Information',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      content: Text('Please enter player name.',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'OK',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text("Start Game"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerNameField(
      TextEditingController controller, String hintText) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: TextField(
        controller: controller,
        cursorColor: Color.fromARGB(255, 71, 160, 233),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Color.fromARGB(255, 177, 211, 240)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 71, 160, 233), width: 2.0),
            borderRadius: BorderRadius.circular(50.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 71, 160, 233).withOpacity(0.5),
                width: 1.5),
            borderRadius: BorderRadius.circular(50.0),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        ),
      ),
    );
  }
}
