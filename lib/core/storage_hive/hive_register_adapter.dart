import 'package:dissertation_project_app/feature/services/to_do_list/data/to_do_hive/to_do_data_hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveRegisterAdapter {
  static Future<void> register() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(ToDoItemHiveAdapter().typeId)) {
      Hive.registerAdapter(ToDoItemHiveAdapter());
    }
  }
}
