import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:miremo/main_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'miremo',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF343A40)),
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel()..getServers(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF343A40),
            elevation: 0,
            toolbarHeight: 80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Text(
                    'player',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                  ),
                ),
                Container(
                  height: 48,
                  width: 48,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: FittedBox(
                      child: Image.network(
                          'https://us-central1-miremo.cloudfunctions.net/app/icon/player?minecraft_id=kit130101',
                          fit: BoxFit.contain),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Center(
            child: Container(
              child: Consumer<MainModel>(
                builder: (context, model, child) {
                  final serverList = model.serverList;
                  return ListView(
                    children: serverList
                        .map(
                          (server) => ListTile(
                            title: Text(server.title),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
