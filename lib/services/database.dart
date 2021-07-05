import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hindsight/models/comparison.dart';
import 'package:hindsight/models/date.dart';
import 'package:hindsight/models/task.dart';
import 'package:hindsight/services/api_path.dart';
import 'package:hindsight/services/firestore_service.dart';
import 'package:intl/intl.dart';

abstract class Database {
  Stream<List<Date>> datesStream();
  Future<void> setDate(Date date);
  Future<void> deleteDate(Date date);

  Stream<List<Task>> tasksStream(Date date);
  Future<void> setTask(Task task);
  Future<void> deleteTask(Date date, Task task);

  Stream<List<Comparison>> comparisonsStream();
  Future<void> setComparison(Comparison comparison);
  Future<void> deleteComparison(Comparison comparison);
}

// For creating unique ids for new entries
String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirestoreService.instance;

  // Getting dates for Fireplace page
  @override
  Stream<List<Date>> datesStream() => _service.collectionStream(
    path: APIPath.dates(uid),
    builder: (data, documentId) => Date.fromMap(data, documentId),
    sort: (a, b) => b.date.compareTo(a.date),
  );

  // Setting date before task to make sure the date itself has a document
  @override
  Future<void> setDate(Date date) {
    _service.setData(
      path: APIPath.date(uid, date.id),
      data: date.toMap(),
    );
  }

  // Deleting all the entries for a date and then deleting the date entry itself
  @override
  Future<void> deleteDate(Date date) async {
    var collection = FirebaseFirestore.instance.collection(APIPath.tasks(uid, date.id));
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
    await _service.deleteData(path: APIPath.date(uid, date.id));
  }

  // Providing the task entries for each date in the Fireplace page
  @override
  Stream<List<Task>> tasksStream(Date date) => _service.collectionStream(
    path: APIPath.tasks(uid, date.id),
    builder: (data, documentId) => Task.fromMap(data, documentId),
    sort: (a, b) => b.start.compareTo(a.start),
  );

  // Creating or updating a task
  @override
  Future<void> setTask(Task task) {
    DateTime dateTime = DateTime(task.start.year, task.start.month, task.start.day);
    String dateId = DateFormat('MM-dd-yyyy').format(dateTime);
    _service.setData(
      path: APIPath.task(uid, dateId, task.id),
      data: task.toMap(),
    );
  }

  // Deleting a task, if that was the last task in the date collection then delete the date too
  @override
  Future<void> deleteTask(Date date, Task task) async {
    await _service.deleteData(
      path: APIPath.task(uid, date.id, task.id),
    );
    print(date.id + task.id);
    var collection = FirebaseFirestore.instance.collection(APIPath.tasks(uid, date.id));
    var snapshots = await collection.get();
    if (snapshots.size == 0) await _service.deleteData(path: APIPath.date(uid, date.id));
  }

  // Providing the comparisons for
  @override
  Stream<List<Comparison>> comparisonsStream() => _service.collectionStream(
    path: APIPath.comparisons(uid),
    builder: (data, documentId) => Comparison.fromMap(data, documentId),
  );

  // Creating a comparison entry in the database
  Future<void> setComparison(Comparison comparison) => _service.setData(
    path: APIPath.comparison(uid, comparison.id),
    data: comparison.toMap(),
  );

  // Removing a comparison entry in the database
  Future<void> deleteComparison(Comparison comparison) async => await _service.deleteData(
    path: APIPath.comparison(uid, comparison.id),
  );
}