import 'package:flutter/material.dart';
import 'package:hindsight/models/task.dart';
import 'package:hindsight/services/api_path.dart';
import 'package:hindsight/services/firestore_service.dart';

abstract class Database {
  Future<void> setTask(Task task);
  Future<void> deleteTask(Task task);
  Stream<List<Task>> tasksStream();
}

// For creating unique ids for new entries
String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirestoreService.instance;

  // Creating or updating a task
  @override
  Future<void> setTask(Task task) => _service.setData(
    path: APIPath.task(uid, task.id),
    data: task.toMap(),
  );

  // Deleting a task
  @override
  Future<void> deleteTask(Task task) async => await _service.deleteData(
    path: APIPath.task(uid, task.id),
  );

  // Providing the task entries for the Fireplace page
  @override
  Stream<List<Task>> tasksStream() => _service.collectionStream(
    path: APIPath.tasks(uid),
    builder: (data, documentId) => Task.fromMap(data, documentId),
  );
}