class APIPath {
  static String dates(String uid) =>
      'users/$uid/dates';
  static String date(String uid, String dateId) =>
      'users/$uid/dates/$dateId';

  static String tasks(String uid, String dateId) =>
      'users/$uid/dates/$dateId/tasks';
  static String task(String uid, String dateId, String taskId) =>
      'users/$uid/dates/$dateId/tasks/$taskId';
}