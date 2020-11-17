import 'package:flutter/material.dart';

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
    } else if ((gamestate[0] != 'empty') &&
        (gamestate[0] == gamestate[3] && (gamestate[0] == gamestate[6]))) {
      this.message = '${this.gamestate[0]} wins';
    } else if ((gamestate[0] != 'empty') &&
        (gamestate[0] == gamestate[4] && (gamestate[0] == gamestate[8]))) {
      this.message = '${this.gamestate[0]} wins';
    } else if ((gamestate[1] != 'empty') &&
        (gamestate[1] == gamestate[4] && (gamestate[1] == gamestate[7]))) {
      this.message = '${this.gamestate[1]} wins';
    } else if ((gamestate[2] != 'empty') &&
        (gamestate[2] == gamestate[4] && (gamestate[2] == gamestate[6]))) {
      this.message = '${this.gamestate[2]} wins';
    } else if ((gamestate[2] != 'empty') &&
        (gamestate[2] == gamestate[5] && (gamestate[2] == gamestate[8]))) {
      this.message = '${this.gamestate[2]} wins';
    } else if ((gamestate[3] != 'empty') &&
        (gamestate[3] == gamestate[4] && (gamestate[3] == gamestate[5]))) {
      this.message = '${this.gamestate[3]} wins';
    } else if ((gamestate[6] != 'empty') &&
        (gamestate[6] == gamestate[7] && (gamestate[7] == gamestate[8]))) {
      this.message = '${this.gamestate[6]} wins';
    }
  }

  playgame(int index) {
    if (this.gamestate[index] == 'empty') {
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
              style: TextStyle(fontSize: 50, color: Colors.deepOrange),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: MaterialButton(
              color: Colors.deepOrange,
              minWidth: 300.0,
              height: 50,
              onPressed: () {
                this.resetgame();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Restart ",
                    style: TextStyle(fontSize: 30),
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
