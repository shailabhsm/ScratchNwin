import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //TODO: import images
  AssetImage circle = AssetImage("images/circle.png");
  AssetImage unlucky = AssetImage("images/sadFace.png");
  AssetImage lucky = AssetImage("images/rupee.png");

  //TODO: get an array
  List<String> itemArray;
  int luckyNumber;
  int attempt = 5;
  String message;

  //TODO: init array with 25 elements
  @override
  void initState() {
    super.initState();
    itemArray = List<String>.generate(25, (index) => "empty");
    this.message = "";
    generateRandomNumber();
  }

  generateRandomNumber() {
    int random = Random().nextInt(25);
    setState(() {
      luckyNumber = random;
    });
  }

  //TODO: define a getImage method
  AssetImage getImage(int index) {
    String currentState = itemArray[index];
    switch (currentState) {
      case "lucky":
        return lucky;
        break;
      case "unlucky":
        return unlucky;
        break;
    }
    return circle;
  }

  //TODO: play game method
  playGame(int index) {
    if (attempt >= 1) {
      if (luckyNumber == index) {
        setState(() {
          itemArray[index] = "lucky";
          attempt = -1;
          this.message = "Game Over!!! You Won The Game.";
        });
      } else {
        setState(() {
          itemArray[index] = "unlucky";
          attempt = attempt - 1;
          checkAttempt();
        });
      }
    } else if (attempt == -1) {
      setState(() {
        this.message = "Game Over!!! You Won The Game.";
      });
    } else {
      setState(() {
        this.message = "Game Over. No Attempt Left.";
      });
    }
  }

  checkAttempt() {
    if (attempt == 0) {
      this.message = "Game Over. No Attempt Left.";
    }
  }

  //TODO: showall
  showAll() {
    setState(() {
      itemArray = List<String>.filled(25, "unlucky");
      itemArray[luckyNumber] = "lucky";
      attempt = 0;
      this.message = "Game Over. No Attempt Left.";
    });
  }

  //TODO: reset game
  resetGame() {
    setState(() {
      itemArray = List<String>.filled(25, "empty");
      this.attempt = 5;
      this.message = "";
    });
    generateRandomNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scratch and Win'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: GridView.builder(
            padding: EdgeInsets.all(20.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0),
            itemBuilder: (context, i) => SizedBox(
              width: 50.0,
              height: 50.0,
              child: RaisedButton(
                onPressed: () {
                  playGame(i);
                },
                child: Image(
                  image: this.getImage(i),
                ),
              ),
            ),
            itemCount: itemArray.length,
          )),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                this.message,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                'Attempt: ${attempt}',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: RaisedButton(
              padding: EdgeInsets.all(15.0),
              onPressed: () {
                this.showAll();
              },
              color: Colors.pink,
              child: Text('Show All',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: RaisedButton(
              padding: EdgeInsets.all(15.0),
              onPressed: () {
                this.resetGame();
              },
              color: Colors.pink,
              child: Text('Reset Game',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            height: 50.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  width: 1,
                  color: Colors.pink,
                ),
              ),
              //color: Colors.black,
              child: Center(
                child: Text(
                  'A Project by Shailabh Suman',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
