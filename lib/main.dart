import 'package:flutter/material.dart';
import 'welcomepagewidget.dart';

void main() {
  runApp(MemoryGame());
}

class MemoryGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String title = "Memory Card";
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.yellow[700],
        ),
        body: WelcomePagWidget(),
      ),
    );
  }
}
