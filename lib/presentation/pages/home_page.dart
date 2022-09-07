import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_game/core/style.dart';
import 'package:flutter_game/data/numbers_list.dart';
import 'package:flutter_game/presentation/widgets/number_key.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userAnswer = '';
  int numberA = 1;
  int numberB = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          //progress menu
          Container(
            color: Colors.cyan,
            height: 200,
          ),

          //input field
          Expanded(
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //for questionn
                    Text(
                      numberA.toString() + "+" + numberB.toString() + "=",
                      style: myStyle,
                    ),
                    //for answer

                    Container(
                      height: 60,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.deepPurple[400],
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        userAnswer,
                        style: myStyle,
                      )),
                    )
                  ],
                ),
              ),
            ),
          ),
          //numpad

          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: numberpad.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Mybutton(
                    child: numberpad[index],
                    onTap: () => buttonTapped(numberpad[index]),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void buttonTapped(String button) {
    setState(() {
      if (button == "=") {
        // calculate numbers anyway
        checkResult();
      } else if (button == "C") {
        //clear answer
        userAnswer = "";
      } else if (button == "DEL") {
        //delete numbers from textfiled
        if (userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        }
      } else if (userAnswer.length < 3) {
        userAnswer += button;
      }
    });
  }

// will check number is correct or not
  void checkResult() {
    if (userAnswer.isNotEmpty) {
      if (numberA + numberB == int.parse(userAnswer)) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.deepPurple,
                content: SizedBox(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "You are correct",
                        style: myStyle,
                      ),
                      InkWell(
                        onTap: () {
                          goToNextQues();
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              color: Color.fromARGB(255, 67, 174, 97)),
                          child: const Padding(
                              padding: EdgeInsets.all(6),
                              child: Icon(Icons.arrow_forward)),
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.deepPurple,
              content: Container(
                height: 200,
                color: Colors.deepPurple,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "You are incorrect",
                      style: myStyle,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.refresh))
                  ],
                ),
              ),
            );
          },
        );
      }
    }
  }

  // random number creator
  var randomNumber = Random();

  void goToNextQues() {
    // dismiss dialog
    Navigator.of(context).pop();

    // reset the answer
    setState(() {
      userAnswer = '';
    });
    numberA = randomNumber.nextInt(100);
    numberB = randomNumber.nextInt(100);
  }
}
