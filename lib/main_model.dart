import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:miremo/server.dart';

class MainModel extends ChangeNotifier {
  List<Server> serverList = [];

  Future getServers() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('servers').get();
    final docs = snapshot.docs;
    final serverList = docs.map((doc) => Server(doc)).toList();
    this.serverList = serverList;
    notifyListeners();
  }
}
