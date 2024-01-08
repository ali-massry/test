import 'package:hive_flutter/hive_flutter.dart';

Box hiveBoxName({required String? boxName}) {
  return Hive.box(boxName ?? '');
}

const String ofllineDataBox = 'offlineData';
const String membersBox = 'membersBox';
