import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class GamePage extends StatelessWidget {
  String difficulty;

  GamePage(this.difficulty);
  @override
  Widget build(BuildContext context) {
    var title = "Memory Card";
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.yellow[700],
      ),
      body: MemoryGameMainPage(difficulty),
    );
  }
}

class MemoryGameMainPage extends StatefulWidget {
  String difficulty;
  MemoryGameMainPage(this.difficulty);
  @override
  _MemoryGameMainPageState createState() => _MemoryGameMainPageState();
}

class _MemoryGameMainPageState extends State<MemoryGameMainPage> {
  List<GlobalKey<FlipCardState>> imageStates;
  Map answers = Map<int, String>();
  int counter = 0;
  int flippedCardCount = 0;
  Timer timer;
  List<String> listImages = [
    "images/lisa.png",
    "images/homer.png",
    "images/bart.png",
    "images/maggie.png",
    "images/marge.png",
    "images/flanders.png",
    "images/lisa.png",
    "images/homer.png",
    "images/bart.png",
    "images/maggie.png",
    "images/marge.png",
    "images/flanders.png",
  ];

  void initKeys() {
    imageStates = <GlobalKey<FlipCardState>>[
      GlobalKey<FlipCardState>(),
      GlobalKey<FlipCardState>(),
      GlobalKey<FlipCardState>(),
      GlobalKey<FlipCardState>(),
      GlobalKey<FlipCardState>(),
      GlobalKey<FlipCardState>(),
      GlobalKey<FlipCardState>(),
      GlobalKey<FlipCardState>(),
      GlobalKey<FlipCardState>(),
      GlobalKey<FlipCardState>(),
      GlobalKey<FlipCardState>(),
      GlobalKey<FlipCardState>(),
    ];
  }

  @override
  void initState() {
    listImages.shuffle();
    initKeys();
    if (widget.difficulty == "Easy") {
      counter = 180;
    } else if (widget.difficulty == "Medium") {
      counter = 120;
    } else {
      counter = 60;
    }

    if (timer != null) {
      timer.cancel();
    } else {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (counter > 0) {
            counter--;
          } else {
            timer.cancel();
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    title: Text("Game Over"),
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                            Navigator.of(dialogContext).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        GamePage(widget.difficulty)));
                          },
                          child: Text("Try Again")),
                      FlatButton(
                          onPressed: () {
                            //Navigator.of(dialogContext)
                            //    .popUntil((route) => route.isFirst);
                            Navigator.of(dialogContext).pop();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Close",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  );
                });
          }
        });
      });
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "Kalan süreniz $counter ",
            style: TextStyle(fontSize: 25),
          ),
        ),
        GridView.builder(
            shrinkWrap: true,
            itemCount: 12,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemBuilder: (context, index) {
              return FlipCard(
                onFlipDone: (value) {
                  if (!value && flippedCardCount % 2 == 0) {
                    if (answers.length == listImages.length) {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              title: Text("You Won"),
                              backgroundColor: Colors.amber,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(dialogContext)
                                          .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          GamePage(widget
                                                              .difficulty)),
                                              (route) => route.isFirst);
                                    },
                                    child: Text("Play Again")),
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(dialogContext)
                                          .popUntil((route) => route.isFirst);
                                    },
                                    child: Text(
                                      "Close",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            );
                          });
                    } else {
                      int count = 0;
                      answers.forEach((key, value) {
                        if (value == listImages[index]) {
                          count++;
                        }
                      });
                      if (count < 2) {
                        answers.clear();
                        imageStates.forEach((element) {
                          if (element.currentState != null &&
                              !element.currentState.isFront) {
                            //element.currentState.toggleCard();
                            Timer(Duration(milliseconds: 200), () {
                              element.currentState.toggleCard();
                              //print("print after every seconds");
                            });
                            //print("call");
                          }
                        });
                      }
                    }
                  }
                },
                key: imageStates[index],
                flipOnTouch: false,
                direction: FlipDirection.VERTICAL,
                speed: 100,
                front: GestureDetector(
                  onTap: () {
                    flippedCardCount++;
                    imageStates[index].currentState.toggleCard();
                    answers[index] = listImages[index];
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        "?",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                back: GestureDetector(
                  onTap: () {
                    imageStates[index].currentState.toggleCard();
                  },
                  child: Container(
                    child: Image.asset(listImages[index]),
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );
            }),
        Text(
          "${widget.difficulty}",
          style: TextStyle(fontSize: 25),
        ),
      ],
    );
  }
}
