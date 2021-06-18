import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miremo/serverCard.dart';

import 'hexColor.dart';

class RegisterModalScreen extends StatefulWidget {
  @override
  _RegisterModalScreenState createState() => _RegisterModalScreenState();
}

class _RegisterModalScreenState extends State<RegisterModalScreen> {
  String _title;
  String _address;
  int _port = 25565;

  FormFieldValidator _requiredValidator(BuildContext context) =>
      (val) => val.isEmpty ? "必須" : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF343A40),
        elevation: 0,
        title: Text(
          'サーバーを追加',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
        child: Column(
          children: <Widget>[
            Container(
              child: ServerCard(_title, null, null, null),
            ),
            Container(
              child: Text(
                '表示名',
                style: TextStyle(
                  color: HexColor('D3D3D3'),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.left,
              ),
              margin: EdgeInsets.fromLTRB(10, 30, 0, 6),
              width: double.infinity,
            ),
            TextFormField(
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
                hintText: 'Minecraftサーバー',
                hintStyle: TextStyle(
                  color: HexColor('80878E'),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                counterStyle: TextStyle(
                  color: HexColor('D3D3D3'),
                  fontSize: 10,
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
              validator: _requiredValidator(context),
              maxLength: 12,
              autofocus: true,
              textInputAction: TextInputAction.next,
              onChanged: (String title) => setState(() => _title = title),
            ),
            Container(
              child: Text(
                'ホスト名',
                style: TextStyle(
                  color: HexColor('D3D3D3'),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.left,
              ),
              margin: EdgeInsets.fromLTRB(10, 0, 0, 6),
              width: double.infinity,
            ),
            TextFormField(
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
                hintText: 'xxxxxx.com, oo.oo.oo.oo',
                hintStyle: TextStyle(
                  color: HexColor('80878E'),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                counterStyle: TextStyle(
                  color: HexColor('D3D3D3'),
                  fontSize: 10,
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
              validator: _requiredValidator(context),
              maxLength: 40,
              textInputAction: TextInputAction.next,
              onChanged: (String address) => setState(() => _address = address),
            ),
            Container(
              child: Text(
                'ポート番号',
                style: TextStyle(
                  color: HexColor('D3D3D3'),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.left,
              ),
              margin: EdgeInsets.fromLTRB(10, 0, 0, 6),
              width: double.infinity,
            ),
            TextFormField(
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
                hintText: '25565',
                hintStyle: TextStyle(
                  color: HexColor('80878E'),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                counterStyle: TextStyle(
                  color: HexColor('D3D3D3'),
                  fontSize: 10,
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
              initialValue: '25565',
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: _requiredValidator(context),
              maxLength: 5,
              textInputAction: TextInputAction.next,
              onChanged: (String port) {
                if (port.isNotEmpty) setState(() => _port = int.parse(port));
              },
            ),
            Container(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 50,
                  width: 175,
                  child: ElevatedButton(
                    child: Text(
                      '作成',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          letterSpacing: 3),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: HexColor('76A3D1'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: (!(_title != null && _title.isNotEmpty) ||
                            !(_address != null && _address.isNotEmpty) ||
                            _port == null)
                        ? null
                        : () async {
                            await FirebaseFirestore.instance
                                .collection('servers')
                                .doc()
                                .set({
                              'title': _title,
                              'address': _address,
                              'port': _port,
                            });
                            Navigator.pop(context, true);
                          },
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 175,
                  child: ElevatedButton(
                    child: Text(
                      'キャンセル',
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
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
