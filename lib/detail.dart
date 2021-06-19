import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detail_model.dart';
import 'hexColor.dart';
import 'memberCard.dart';

class DetailScreen extends StatefulWidget {
  String _title;
  String _address;
  int _port;

  DetailScreen(this._title, this._address, this._port);

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
        create: (_) =>
        DetailModel()
          ..getOnlinePlayers(widget._title, widget._address, widget._port),
        child: Scaffold(
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
                        Column(
                          children: <Widget>[
                            ListView(
                              children: onlinePlayerList
                                  .map((player) =>
                                  MemberCardScreen(
                                      player.id, player.iconUrl))
                                  .toList(),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
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
}
