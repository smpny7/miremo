import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'hexColor.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String minecraftId = '';
  bool isContinuable = false;

  void minecraftValidation(String minecraftId) async {
    final url = Uri.parse(
        'https://us-central1-miremo.cloudfunctions.net/app/icon/player?minecraft_id=$minecraftId');
    final response = await http.get(url);
    setState(() {
      this.minecraftId = minecraftId;
      this.isContinuable = response.statusCode == 200;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: 100),
            Container(
              height: 80,
              width: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: FittedBox(
                  child: minecraftId == ''
                      ? Image.asset('assets/player.png')
                      : Image.network(
                          'https://us-central1-miremo.cloudfunctions.net/app/icon/player?minecraft_id=$minecraftId',
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace stackTrace) {
                            return Image.asset('assets/player.png');
                          },
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.none,
                        ),
                ),
              ),
            ),
            Container(
              child: Text(
                'Minecraft ID を登録',
                style: TextStyle(
                  color: HexColor('D3D3D3'),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.left,
              ),
              margin: EdgeInsets.fromLTRB(40, 40, 40, 20),
              width: double.infinity,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: HexColor('505962'),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: HexColor('505962'),
                      ),
                    ),
                    filled: true,
                    fillColor: HexColor('505962'),
                    counterStyle: TextStyle(
                      color: HexColor('D3D3D3'),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  style: TextStyle(
                    color: HexColor('D3D3D3'),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                  textInputAction: TextInputAction.next,
                  onChanged: (String minecraftId) =>
                      minecraftValidation(minecraftId)),
            ),
            isContinuable || minecraftId == ''
                ? SizedBox.shrink()
                : Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: HexColor('FF5050'),
                          size: 16,
                        ),
                        Container(width: 4),
                        Text(
                          'この Minecraft ID は存在しません',
                          style: TextStyle(
                            color: HexColor('FF5050'),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    margin: EdgeInsets.fromLTRB(40, 10, 40, 20),
                    width: double.infinity,
                  ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  40, isContinuable || minecraftId == '' ? 40 : 10, 40, 0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    '登録する',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        letterSpacing: 5),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: HexColor('76A3D1'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: isContinuable
                      ? () async {
                          await FirebaseFirestore.instance
                              .collection('members')
                              .doc(FirebaseAuth.instance.currentUser.uid)
                              .set({'minecraftId': minecraftId});
                          Navigator.pushReplacementNamed(context, '/home');
                        }
                      : null,
                ),
              ),
            ),
            Container(height: 60),
          ],
        ),
      ),
    );
  }
}
