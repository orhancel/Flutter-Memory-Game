import 'package:flutter/material.dart';
import 'gamepage.dart';

String dropdownValue = 'Easy';

class DifficulyOption extends StatefulWidget {
  @override
  _DifficulyOptionState createState() => _DifficulyOptionState();
}

class _DifficulyOptionState extends State<DifficulyOption> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.amber[200],
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.amber[700]),
        underline: Container(
          height: 2,
          color: Colors.amberAccent,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>['Easy', 'Medium', 'Hard']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

class WelcomePagWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "Flutter Memory Game",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          Center(
            child: RaisedButton(
              color: Colors.amber,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GamePage(dropdownValue)),
                );
              },
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              child: Text(
                "New Game",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Difficulty",
                style: TextStyle(
                    color: Colors.amber[700], fontWeight: FontWeight.bold),
              ),
              DifficulyOption(),
            ],
          )
        ],
      ),
    );
  }
}
