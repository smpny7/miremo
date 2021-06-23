import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:miremo/main_model.dart';
import 'package:miremo/privacyPolicy.dart';
import 'package:miremo/register.dart';
import 'package:miremo/registerModal.dart';
import 'package:miremo/serverCard.dart';
import 'package:provider/provider.dart';

import 'hexColor.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MaterialApp(
    title: 'miremo',
    theme: ThemeData(scaffoldBackgroundColor: HexColor('343A40')),
    home: LoginScreen(),
    routes: <String, WidgetBuilder>{
      // '/': (_) => new Splash(),
      '/login': (_) => new LoginScreen(),
      '/register': (_) => new RegisterScreen(),
      '/home': (_) => new HomeScreen(),
      '/privacyPolicy': (_) => new PrivacyPolicyScreen(),
    },
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isEditable = false;
  String minecraftId = '';

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void _toggleEditable() => setState(() => _isEditable = !_isEditable);

  void getMinecraftId() async {
    final doc = await FirebaseFirestore.instance
        .collection('members')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    setState(() => this.minecraftId = doc.data()['minecraftId']);
  }

  void flutterEmailSenderMail() async {
    final Email email = Email(recipients: ['developer.ikep@gmail.com']);
    await FlutterEmailSender.send(email);
  }

  Future<void> signOut(context) async {
    await FirebaseAuth.instance.signOut();
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      print(e);
    }
    Navigator.pushReplacementNamed(context, "/login");
  }

  @override
  void initState() {
    super.initState();
    getMinecraftId();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(
      create: (_) => MainModel()..getServers(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor('343A40'),
          elevation: 0,
          toolbarHeight: 70,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: Text(
                  minecraftId,
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
                        'https://us-central1-miremo.cloudfunctions.net/app/icon/player?minecraft_id=$minecraftId',
                        fit: BoxFit.contain),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Consumer<MainModel>(
              builder: (context, model, child) {
                final serverList = model.serverList;
                return RefreshIndicator(
                  backgroundColor: HexColor('505962'),
                  color: HexColor('76A3D1'),
                  onRefresh: () async =>
                      Provider.of<MainModel>(context, listen: false)
                          .getServers(),
                  child: ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: <Widget>[
                      serverList.length > 0
                          ? Column(
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
                            )
                          : Container(
                              margin: EdgeInsets.only(top: 30),
                              child: ElevatedButton(
                                child: Container(
                                  height: 95,
                                  child: ListTile(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(5, 20, 5, 0),
                                    title: Text(
                                      '新規サーバーを追加',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2),
                                    ),
                                    trailing: Container(
                                      height: 60,
                                      width: 60,
                                      child: Image.asset('assets/server.png'),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: HexColor('7AA5D2'),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                                onPressed: () => showRegisterModal(context),
                              ),
                            ),
                      Container(height: 30),
                      serverList.length > 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: _isEditable
                                          ? null
                                          : () => showRegisterModal(context),
                                    ),
                                  ),
                                ),
                                Container(width: 20),
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () => _toggleEditable(),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox.shrink(),
                      Container(height: 60),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text(
                            'プライバシーポリシー',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                letterSpacing: 5),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: HexColor('505962'),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PrivacyPolicyScreen(),
                            ),
                          ),
                        ),
                      ),
                      Container(height: 10),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text(
                            'お問い合わせ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                letterSpacing: 5),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: HexColor('505962'),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => flutterEmailSenderMail(),
                        ),
                      ),
                      Container(height: 10),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text(
                            'サインアウト',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                letterSpacing: 5),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: HexColor('625050'),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => signOut(context),
                        ),
                      ),
                      Container(height: 60),
                    ],
                  ),
                );
              },
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

    if (result != null)
      Provider.of<MainModel>(context, listen: false).getServers();
  }
}
