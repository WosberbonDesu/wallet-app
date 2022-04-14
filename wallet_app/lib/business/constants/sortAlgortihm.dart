class sortAlgorithms {
  DateTime minAgo = DateTime.now().subtract(const Duration(days: 1));
  DateTime weekAgo = DateTime.now().subtract(const Duration(days: 7));
  DateTime monthAgo = DateTime.now().subtract(const Duration(days: 31));
  DateTime yearAgo = DateTime.now().subtract(const Duration(days: 365));
}

int DaysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

final birthDay = DateTime(1967, 10, 12);
final date2 = DateTime.now();

final difference = DaysBetween(birthDay, date2);
