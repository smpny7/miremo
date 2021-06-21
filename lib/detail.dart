import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detail_model.dart';
import 'hexColor.dart';
import 'memberCard.dart';

class DetailScreen extends StatefulWidget {
  final String _title;
  final String _address;
  final int _port;
  final String _iconUrl;
  final int _capacityMembers;

  DetailScreen(this._title, this._address, this._port, this._iconUrl,
      this._capacityMembers);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'miremo',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF343A40)),
      home: ChangeNotifierProvider<DetailModel>(
        create: (_) => DetailModel()
          ..getOnlinePlayers(widget._title, widget._address, widget._port),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF343A40),
            elevation: 0,
            toolbarHeight: 70,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
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
              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Consumer<DetailModel>(
                builder: (context, model, child) {
                  final onlinePlayerList = model.onlinePlayerList;
                  return RefreshIndicator(
                    backgroundColor: HexColor('505962'),
                    color: HexColor('76A3D1'),
                    onRefresh: () async =>
                        Provider.of<DetailModel>(context, listen: false)
                            .getOnlinePlayers(
                                widget._title, widget._address, widget._port),
                    child: ListView(
                      physics: AlwaysScrollableScrollPhysics(),
                      children: <Widget>[
                        RaisedButton(
                          color: HexColor('7AA5D2'),
                          child: Container(
                            height: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ListTile(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(3, 0, 3, 0),
                                  leading: Container(
                                    height: 60,
                                    width: 60,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: FittedBox(
                                        child: widget._iconUrl != null
                                            ? Image.network(widget._iconUrl,
                                                fit: BoxFit.contain)
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
                                    'オンライン: ${onlinePlayerList.length ?? '-'} / ${widget._capacityMembers ?? '-'}',
                                    style: TextStyle(
                                        color: Colors.white,
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
                        onlinePlayerList.length > 0
                            ? Column(
                                children: <Widget>[
                                  ListView(
                                    children: onlinePlayerList
                                        .map((player) => MemberCardScreen(
                                            player.id, player.iconUrl))
                                        .toList(),
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                  ),
                                ],
                              )
                            : Card(
                                color: HexColor('505962'),
                                margin: EdgeInsets.only(top: 30),
                                child: SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Container(height: 30),
                                        Icon(
                                          Icons.info,
                                          color: HexColor('A5AFBA'),
                                          size: 50,
                                        ),
                                        Container(height: 10),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 30),
                                          child: Text(
                                            'オンラインメンバーがいないか\nサーバーから情報が提供されて\nいない可能性があります。',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: HexColor('A5AFBA'),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 2),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
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
}
