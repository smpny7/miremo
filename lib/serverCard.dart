import 'package:flutter/material.dart';
import 'package:miremo/registerModal.dart';
import 'package:provider/provider.dart';

import 'main_model.dart';

class ServerCardScreen extends StatefulWidget {
  final String _title;
  final String _address;
  final int _port;
  final String _documentID;
  final String _iconUrl;
  final int _onlineMembers;
  final int _capacityMembers;
  bool _isEditable;

  ServerCardScreen(
      this._title,
      this._address,
      this._port,
      this._documentID,
      this._iconUrl,
      this._onlineMembers,
      this._capacityMembers,
      this._isEditable);

  @override
  _ServerCardScreenState createState() => _ServerCardScreenState();
}

class _ServerCardScreenState extends State<ServerCardScreen> {
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
                      child: widget._iconUrl != null
                          ? Image.network(widget._iconUrl, fit: BoxFit.contain)
                          : Image.asset('assets/default.jpg'),
                    ),
                  ),
                ),
                title: Text(
                  widget._title ?? 'Minecraftサーバー',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
                subtitle: Text(
                  'オンライン: ${widget._onlineMembers ?? '-'} / ${widget._capacityMembers ?? '-'}',
                  style: TextStyle(
                      color: Color(0xFFD3D3D3),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
                trailing: widget._isEditable
                    ? IconButton(
                        color: Colors.white70,
                        icon: Icon(Icons.edit),
                        onPressed: widget._isEditable
                            ? () => showEditModal(context)
                            : null,
                        iconSize: 20)
                    : SizedBox.shrink(),
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

  void showEditModal(BuildContext context) async {
    final result = await Navigator.push(
      context,
      new MaterialPageRoute<bool>(
        builder: (BuildContext context) => RegisterModalScreen(widget._title,
            widget._address, widget._port, widget._documentID, widget._iconUrl),
        fullscreenDialog: true,
      ),
    );

    if (result != null) Provider.of<MainModel>(context, listen: false).getServers();
  }
}
