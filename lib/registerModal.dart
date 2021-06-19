import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miremo/serverCard.dart';

import 'hexColor.dart';

class RegisterModalScreen extends StatefulWidget {
  String _title;
  String _address;
  int _port;
  String _documentID;
  String _iconUrl;

  RegisterModalScreen(
      this._title, this._address, this._port, this._documentID, this._iconUrl);

  @override
  _RegisterModalScreenState createState() => _RegisterModalScreenState();
}

class _RegisterModalScreenState extends State<RegisterModalScreen> {
  FormFieldValidator _requiredValidator(BuildContext context) =>
      (val) => val.isEmpty ? "必須" : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF343A40),
        elevation: 0,
        title: Text(
          widget._documentID == null ? 'サーバーを追加' : 'サーバーを編集',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: Column(
            children: <Widget>[
              Container(
                child: ServerCardScreen(
                    widget._title,
                    widget._address,
                    widget._port,
                    widget._documentID,
                    widget._iconUrl,
                    null,
                    null,
                    false),
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
                initialValue: widget._title ?? '',
                validator: _requiredValidator(context),
                maxLength: 12,
                autofocus: true,
                textInputAction: TextInputAction.next,
                onChanged: (String title) =>
                    setState(() => widget._title = title),
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
                initialValue: widget._address ?? '',
                validator: _requiredValidator(context),
                maxLength: 40,
                textInputAction: TextInputAction.next,
                onChanged: (String address) =>
                    setState(() => widget._address = address),
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
                initialValue: widget._port.toString() ?? '25565',
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: _requiredValidator(context),
                maxLength: 5,
                textInputAction: TextInputAction.next,
                onChanged: (String port) {
                  if (port.isNotEmpty)
                    setState(() => widget._port = int.parse(port));
                },
              ),
              Container(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      width: 140,
                      child: ElevatedButton(
                        child: Text(
                          widget._documentID == null ? '作成' : '保存',
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
                        onPressed: (!(widget._title != null &&
                                    widget._title.isNotEmpty) ||
                                !(widget._address != null &&
                                    widget._address.isNotEmpty) ||
                                widget._port == null)
                            ? null
                            : () async {
                                widget._documentID == null
                                    ? await FirebaseFirestore.instance
                                        .collection('servers')
                                        .doc()
                                        .set({
                                        'title': widget._title,
                                        'address': widget._address,
                                        'port': widget._port,
                                      })
                                    : await FirebaseFirestore.instance
                                        .collection('servers')
                                        .doc(widget._documentID)
                                        .update({
                                        'title': widget._title,
                                        'address': widget._address,
                                        'port': widget._port,
                                      });
                                Navigator.pop(context, true);
                              },
                      ),
                    ),
                  ),
                  Container(width: 20),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      width: 140,
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
                  ),
                ],
              ),
              widget._documentID == null
                  ? SizedBox.shrink()
                  : Container(height: 20),
              widget._documentID == null
                  ? SizedBox.shrink()
                  : SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text(
                          '削除',
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
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('servers')
                              .doc(widget._documentID)
                              .delete();
                          Navigator.pop(context, true);
                        },
                      ),
                    ),
              Container(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
