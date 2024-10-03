

import 'package:dissertation_project_app/feature/services/hive/to_do_hive/to_do_data_hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RegisterAdapterPerformer {
  static Future<void> register() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(ToDoItemHiveAdapter().typeId)) {
      Hive.registerAdapter(ToDoItemHiveAdapter());
    }

    // if (!Hive.isAdapterRegistered(FormDataHiveAdapter().typeId)) {
    //   Hive.registerAdapter(FormDataHiveAdapter());
    // }
  }
}
