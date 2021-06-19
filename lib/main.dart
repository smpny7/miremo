import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:miremo/main_model.dart';
import 'package:miremo/registerModal.dart';
import 'package:miremo/serverCard.dart';
import 'package:provider/provider.dart';

import 'hexColor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HomeScreen());
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isEditable = false;

  void _toggleEditable() => setState(() => _isEditable = !_isEditable);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'miremo',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF343A40)),
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel()..getServers(),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xFF343A40),
            elevation: 0,
            toolbarHeight: 80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: Text(
                    'kit130101',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
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
              margin: EdgeInsets.fromLTRB(30, 50, 30, 0),
              child: Consumer<MainModel>(
                builder: (context, model, child) {
                  final serverList = model.serverList;
                  return RefreshIndicator(
                    backgroundColor: HexColor('505962'),
                    color: HexColor('76A3D1'),
                    onRefresh: () async {
                      Provider.of<MainModel>(context, listen: false)
                          .getServers();
                    },
                    child: ListView(
                      physics: AlwaysScrollableScrollPhysics(),
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            ListView(
                              children: serverList
                                  .map((server) => ServerCardScreen(
                                      server.title,
                                      server.address,
                                      server.port,
                                      server.documentID,
                                      server.iconUrl,
                                      server.onlineMembers,
                                      server.capacityMembers,
                                      _isEditable))
                                  .toList(),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                            ),
                          ],
                        ),
                        Container(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              height: 50,
                              width: 175,
                              child: ElevatedButton(
                                child: Text(
                                  'サーバーを追加',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      letterSpacing: 2),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: HexColor('76A3D1'),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: _isEditable
                                    ? null
                                    : () => showRegisterModal(context),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: 175,
                              child: ElevatedButton(
                                child: Text(
                                  _isEditable ? 'キャンセル' : '編集',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      letterSpacing: 3),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: HexColor('505962'),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () => _toggleEditable(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showRegisterModal(BuildContext context) async {
    final result = await Navigator.push(
      context,
      new MaterialPageRoute<bool>(
        builder: (BuildContext context) =>
            RegisterModalScreen(null, null, 25565, null, null),
        fullscreenDialog: true,
      ),
    );

    if (result) Provider.of<MainModel>(context, listen: false).getServers();
  }
}
