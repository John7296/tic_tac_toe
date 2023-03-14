import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool firstTap = true;
  List<String> displayCharacter = ['', '', '', '', '', '', '', '', ''];
  int boxCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[200],
        centerTitle: true,
        title: Text(
          "Tic-Tac-Toe",
          style: TextStyle(
              color: Color(0xff343641),
              fontSize: 26,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Center(
            child: Container(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                    itemCount: 9,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          tapped(index);
                          print(displayCharacter[index]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xff343641),
                              border: Border.all(
                                width: 1,
                                color: Colors.white,
                              )),
                          child: Center(
                              child: Text(
                            displayCharacter[index],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      );
                    }),
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xff343641))),
                onPressed: () {
                  clearBox();
                },
                child: Text("Clear")),
          )
        ],
      ),
    );
  }

  void tapped(int index) {
    setState(() {
      if (firstTap && displayCharacter[index] == '') {
        displayCharacter[index] = 'O';
        boxCount++;
      } else if (!firstTap && displayCharacter[index] == '') {
        displayCharacter[index] = 'X';
        boxCount++;
      }

      firstTap = !firstTap;
      checkWinner();
    });
  }

  void checkWinner() {
//Row Check
    if (displayCharacter[0] == displayCharacter[1] &&
        displayCharacter[0] == displayCharacter[2] &&
        displayCharacter[0] != '') {
      winnerDialouge(displayCharacter[0]);
    }
    if (displayCharacter[3] == displayCharacter[4] &&
        displayCharacter[3] == displayCharacter[5] &&
        displayCharacter[3] != '') {
      winnerDialouge(displayCharacter[3]);
    }
    if (displayCharacter[6] == displayCharacter[7] &&
        displayCharacter[6] == displayCharacter[8] &&
        displayCharacter[6] != '') {
      winnerDialouge(displayCharacter[6]);
    }

    //Column Check
    if (displayCharacter[0] != '' &&
        displayCharacter[0] == displayCharacter[3] &&
        displayCharacter[0] == displayCharacter[6]) {
      winnerDialouge(displayCharacter[0]);
    }
    if (displayCharacter[1] != '' &&
        displayCharacter[1] == displayCharacter[4] &&
        displayCharacter[1] == displayCharacter[7]) {
      winnerDialouge(displayCharacter[1]);
    }
    if (displayCharacter[2] != '' &&
        displayCharacter[2] == displayCharacter[5] &&
        displayCharacter[2] == displayCharacter[8]) {
      winnerDialouge(displayCharacter[2]);
    }

    // Diagonal Check
    if (displayCharacter[0] != '' &&
        displayCharacter[0] == displayCharacter[4] &&
        displayCharacter[0] == displayCharacter[8]) {
      winnerDialouge(displayCharacter[0]);
    }

    if (displayCharacter[2] != '' &&
        displayCharacter[2] == displayCharacter[4] &&
        displayCharacter[2] == displayCharacter[6]) {
      winnerDialouge(displayCharacter[2]);
    } else if (boxCount == 9) {
      drawDialog();
    }
  }

  void winnerDialouge(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('winner is' + winner),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xff343641))),
                child: Text("Play Again"),
                onPressed: () {
                  clearBox();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void drawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Draw"),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xff343641))),
                child: Text("Play Again"),
                onPressed: () {
                  clearBox();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void clearBox() {
    setState(() {
      for (int index = 0; index <= 8; index++) {
        displayCharacter[index] = '';
      }
    });
    boxCount = 0;
  }
}
