import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:miremo/player.dart';

class DetailModel extends ChangeNotifier {
  List<Player> onlinePlayerList = [];

  Future getOnlinePlayers(String title, String address, int port) async {
    final firebaseUri = 'https://us-central1-miremo.cloudfunctions.net/app/';
    final url =
        Uri.parse('${firebaseUri}status/online?host=$address&port=$port');
    final response = await http.get(url);
    final jsonResponse = json.decode(response.body)['data'];

    final onlinePlayerList = (jsonResponse
        .map((player) => getServerStatus(player['name']))).toList();

    this.onlinePlayerList = onlinePlayerList.cast<Player>();
    notifyListeners();
  }

  Player getServerStatus(minecraftId) {
    final firebaseUri = 'https://us-central1-miremo.cloudfunctions.net/app/';
    return Player(
        minecraftId, '${firebaseUri}icon/player?minecraft_id=$minecraftId');
  }
}
