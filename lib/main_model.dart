import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:miremo/server.dart';

class MainModel extends ChangeNotifier {
  List<Server> serverList = [];

  Future getServers() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('servers').get();
    final docs = snapshot.docs;

    final serverList =
        await Future.wait(docs.map((doc) => getServerStatus(doc)).toList());

    this.serverList = serverList;
    notifyListeners();
  }

  Future<Server> getServerStatus(doc) async {
    final firebaseUri = 'https://us-central1-miremo.cloudfunctions.net/app/';
    final url = Uri.parse(
        '${firebaseUri}status?host=${doc.data()['address']}&port=${doc.data()['port']}');
    final response = await http.get(url);
    final jsonResponse = json.decode(response.body);

    return Server(
        doc.data()['title'],
        '${firebaseUri}icon/server?host=${doc.data()['address']}&port=${doc.data()['port']}',
        jsonResponse['data']['players']['online'],
        jsonResponse['data']['players']['max']);
  }
}
