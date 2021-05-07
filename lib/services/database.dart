import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hindsight/models/entry.dart';
import 'package:hindsight/services/api_path.dart';

abstract class Database {
  Future<void> createEntry(Entry entry);
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  Future<void> createEntry(Entry entry) => _setData(
    path: APIPath.entry(uid, 'entry_123'),
    data: entry.toMap(),
  );

  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final documentReference = FirebaseFirestore.instance.doc(path);
    await documentReference.set(data);
  }
}