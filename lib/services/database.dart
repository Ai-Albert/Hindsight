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
  Stream<Task> taskStream(Date date, String taskId);
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

  // Deleting all the tasks for a date and then deleting the date entry itself
  @override
  Future<void> deleteDate(Date date) async {

    // Deleting tasks
    var dateTasks = FirebaseFirestore.instance.collection(APIPath.tasks(uid, date.id));
    var snapshotsTasks = await dateTasks.get();
    for (var task in snapshotsTasks.docs) {

      // Going through comparisons to delete those that include the current task being examined
      var comparisons = FirebaseFirestore.instance.collection(APIPath.comparisons(uid));
      var snapshotsComparisons = await comparisons.get();
      for (var comparison in snapshotsComparisons.docs) {
        if (comparison.id.contains(task.id)) await comparison.reference.delete();
      }

      await task.reference.delete();
    }

    // Deleting date
    await _service.deleteData(path: APIPath.date(uid, date.id));
  }

  // Providing the task entries for each date in the Fireplace page
  @override
  Stream<List<Task>> tasksStream(Date date) => _service.collectionStream(
    path: APIPath.tasks(uid, date.id),
    builder: (data, documentId) => Task.fromMap(data, documentId),
    sort: (a, b) => b.start.compareTo(a.start),
  );

  // Getting individual tasks for comparisons
  @override
  Stream<Task> taskStream(Date date, String taskId) => _service.documentStream(
    path: APIPath.task(uid, date.id, taskId),
    builder: (data, documentId) => Task.fromMap(data, documentId),
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
    // Deleting comparisons relating to the task
    var comparisons = FirebaseFirestore.instance.collection(APIPath.comparisons(uid));
    var snapshotsComparisons = await comparisons.get();
    for (var comparison in snapshotsComparisons.docs) {
      if (comparison.id.contains(task.id)) await comparison.reference.delete();
    }

    // Deleting task
    await _service.deleteData(
      path: APIPath.task(uid, date.id, task.id),
    );

    // Deleting the date if this was the last task for that date
    var collection = FirebaseFirestore.instance.collection(APIPath.tasks(uid, date.id));
    var snapshots = await collection.get();
    if (snapshots.size == 0) await _service.deleteData(path: APIPath.date(uid, date.id));
  }

  // Providing the comparisons for
  @override
  Stream<List<Comparison>> comparisonsStream() => _service.collectionStream(
    path: APIPath.comparisons(uid),
    builder: (data, documentId) => Comparison.fromMap(data, documentId),
    sort: (a,b) => b.start1.compareTo(a.start1),
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