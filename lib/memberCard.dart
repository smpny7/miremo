import 'package:flutter/material.dart';

import 'hexColor.dart';

class MemberCardScreen extends StatelessWidget {
  final String _minecraftId;
  final String _iconUrl;

  MemberCardScreen(this._minecraftId, this._iconUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: RaisedButton(
        color: Color(0xFF505962),
        child: Container(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                leading: Container(
                  height: 60,
                  width: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: FittedBox(
                      child: Image.network(
                        _iconUrl,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.none,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  _minecraftId,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
                subtitle: Text(
                  'オンライン',
                  style: TextStyle(
                      color: HexColor('1CD644'),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
