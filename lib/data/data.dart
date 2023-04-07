import 'package:hive_flutter/hive_flutter.dart';

void save(DateTime date, int repertoireTime, int technicTime,
    int analysisTime) async {
  final year = date.year;
  final diff = date.difference(DateTime(year, 1, 1, 0, 0));
  final day = diff.inDays + 1;

  final box = await Hive.openBox<List<int>>(year.toString());

  await box.put(day, <int>[repertoireTime, technicTime, analysisTime]);

  await box.close();
}

Future<List<int>?> load(DateTime date) async {
  final year = date.year;
  final diff = date.difference(DateTime(year, 1, 1, 0, 0));
  final day = diff.inDays + 1;

  final box = await Hive.openBox<List<int>>(year.toString());
  final times = await box.get(day);
  await box.close();

  return times;
}
