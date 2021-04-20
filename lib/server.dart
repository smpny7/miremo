import 'package:cloud_firestore/cloud_firestore.dart';

class Server {
  String title;
  String iconUrl;
  int onlineMembers;
  int capacityMembers;

  Server(DocumentSnapshot doc) {
    this.title = doc.data()['title'];
    this.iconUrl = doc.data()['iconUrl'];
    this.onlineMembers = doc.data()['onlineMembers'];
    this.capacityMembers = doc.data()['capacityMembers'];
  }
}
