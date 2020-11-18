import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  //TODO: linkup image

  AssetImage circle = AssetImage("images/circle.png");
  AssetImage cross = AssetImage("images/cross.png");
  AssetImage dot = AssetImage("images/dot.png");

  bool isCross = true;
  String message;
  List<String> gamestate;
  int _start = 5;

  //TODO: initialize the state of box with empty
  void initState() {
    super.initState();
    setState(() {
      this.gamestate = [
        'empty',
        'empty',
        'empty',
        'empty',
        'empty',
        'empty',
        'empty',
        'empty',
        'empty',
      ];
      this.message = '';
    });
  }

  Timer _timer;

  void startTimer() {
    const onesec = const Duration(seconds: 1);
    _timer = Timer.periodic(
        onesec,
        (Timer timer) => setState(() {
              if (_start == 0) {
                timer.cancel();
                resetgame();
                _start = 5;
              } else {
                _start = _start - 1;
              }
            }));
  }

  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  //TODO: playgame method
  getImage(String value) {
    switch (value) {
      case ('empty'):
        return dot;
        break;
      case ('circle'):
        return circle;
        break;
      case ('cross'):
        return cross;
        break;
    }
  }

  checkwin() {
    if ((gamestate[0] != 'empty') &&
        (gamestate[0] == gamestate[1] && (gamestate[0] == gamestate[2]))) {
      this.message = '${this.gamestate[0]} wins';
      startTimer();
    } else if ((gamestate[0] != 'empty') &&
        (gamestate[0] == gamestate[3] && (gamestate[0] == gamestate[6]))) {
      this.message = '${this.gamestate[0]} wins';
      startTimer();
    } else if ((gamestate[0] != 'empty') &&
        (gamestate[0] == gamestate[4] && (gamestate[0] == gamestate[8]))) {
      this.message = '${this.gamestate[0]} wins';
      startTimer();
    } else if ((gamestate[1] != 'empty') &&
        (gamestate[1] == gamestate[4] && (gamestate[1] == gamestate[7]))) {
      this.message = '${this.gamestate[1]} wins';
      startTimer();
    } else if ((gamestate[2] != 'empty') &&
        (gamestate[2] == gamestate[4] && (gamestate[2] == gamestate[6]))) {
      this.message = '${this.gamestate[2]} wins';
      startTimer();
    } else if ((gamestate[2] != 'empty') &&
        (gamestate[2] == gamestate[5] && (gamestate[2] == gamestate[8]))) {
      this.message = '${this.gamestate[2]} wins';
      startTimer();
    } else if ((gamestate[3] != 'empty') &&
        (gamestate[3] == gamestate[4] && (gamestate[3] == gamestate[5]))) {
      this.message = '${this.gamestate[3]} wins';
      startTimer();
    } else if ((gamestate[6] != 'empty') &&
        (gamestate[6] == gamestate[7] && (gamestate[7] == gamestate[8]))) {
      this.message = '${this.gamestate[6]} wins';
      startTimer();
    } else if (!gamestate.contains('empty')) {
      this.message = "match draw";
      startTimer();
    }
  }

  playgame(int index) {
    if (this.gamestate[index] == 'empty' && this.message == '') {
      setState(() {
        if (isCross == true) {
          this.gamestate[index] = 'cross';
        } else {
          this.gamestate[index] = 'circle';
        }
        this.isCross = !this.isCross;
        this.checkwin();
      });
    }
  }

  //TODO: reset game

  resetgame() {
    setState(() {
      this.gamestate = [
        'empty',
        'empty',
        'empty',
        'empty',
        'empty',
        'empty',
        'empty',
        'empty',
        'empty',
      ];
      this.message = '';
    });
  }
  //TODO: get image method

  //TODO: check for winnig logic

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('TicTacToe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.all(10)),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0),
              itemCount: 9,
              itemBuilder: (context, i) => SizedBox(
                width: 100.0,
                height: 100.0,
                child: MaterialButton(
                  onPressed: () {
                    this.playgame(i);
                  },
                  child: Image(image: this.getImage(this.gamestate[i])),
                ),
              ),
            ),
          ),
          Container(
            child: Text(
              this.message,
              style: TextStyle(fontSize: 50, color: Colors.grey),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: MaterialButton(
              color: Colors.redAccent,
              minWidth: 300.0,
              height: 50,
              onPressed: () {
                this.resetgame();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (this.message == '')
                      ? Text(
                          "Restart ",
                          style: TextStyle(fontSize: 20),
                        )
                      : Text(
                          "Restarting in $_start sec. ",
                          style: TextStyle(fontSize: 20),
                        ),
                  Icon(Icons.refresh),
                ],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
        ],
      ),
    );
  }
}
