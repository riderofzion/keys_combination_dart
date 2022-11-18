import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    window.onKeyPress.listen((KeyboardEvent  event) {
      print("press ${event.key}");
      detectCombinations(EventTypeOn.Press, event.key!);

    });
    window.onKeyUp.listen((KeyboardEvent  event) {
      print("up ${event.key}");
      detectCombinations(EventTypeOn.Up, event.key!);

    });
    window.onKeyDown.listen((KeyboardEvent event) {
      print("down ${event.key}");
      detectCombinations(EventTypeOn.Down, event.key!);
    });
  }
  //We set KeySaved to Empty when key is down and up just after without any key
  // between thos two events
  String? keySaved  = null;
  String? keyCombined = null;
  void detectCombinations(EventTypeOn type, String nameKey){
    if(type == EventTypeOn.Down){
      if(keySaved == null){
        keySaved = nameKey;
      }else{
        keyCombined = nameKey;
      }
    }
    else if(type == EventTypeOn.Up){
      if(keyCombined != null && nameKey == keySaved){
        showKeyToUser("$keySaved$keyCombined");
        keyCombined = null;
        keySaved = null;
      }else if (keyCombined == null && keySaved == nameKey){
        showKeyToUser("$keySaved");
        keySaved = null;
      }
    }
  }

  void showKeyToUser(String comboKey){
    if(comboKey.length == 1){
      print ("the key pressed is $comboKey");
    }else{
      print ("the combo pressed is $comboKey");

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'ldgmkdfg'
            ),
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

enum EventTypeOn{
  Up,Down,Press
}