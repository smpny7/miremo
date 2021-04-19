import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'miremo',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF343A40)),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 120, 0, 0),
                height: 120,
                width: 120,
                child: FittedBox(
                  child: Image.network(
                      'https://us-central1-miremo.cloudfunctions.net/app/icon/player?minecraft_id=kit130101',
                      fit: BoxFit.contain),
                )
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text('池田海斗',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 5)
                  )
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                  child: Text('kit130101',
                      style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2)
                  )
              )
          ]
        )
      )
    );
  }
}
