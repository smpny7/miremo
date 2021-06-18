import 'package:flutter/material.dart';

class ServerCard extends StatelessWidget {
  final String _title;
  final String _iconUrl;
  final int _onlineMembers;
  final int _capacityMembers;

  ServerCard(
      this._title, this._iconUrl, this._onlineMembers, this._capacityMembers);

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
                leading: Container(
                  height: 60,
                  width: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: FittedBox(
                      child: _iconUrl != null
                          ? Image.network(_iconUrl, fit: BoxFit.contain)
                          : Image.asset('assets/default.jpg'),
                    ),
                  ),
                ),
                title: Text(
                  _title ?? 'Minecraftサーバー',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
                subtitle: Text(
                  'オンライン: ${_onlineMembers ?? '-'} / ${_capacityMembers ?? '-'}',
                  style: TextStyle(
                      color: Color(0xFFD3D3D3),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
                // trailing: IconButton(
                //     color: Colors.white70,
                //     icon: _iconUrl != null ? Icon(EnterIcon.enter) : Icon(null),
                //     onPressed: () {},
                //     iconSize: 34),
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
