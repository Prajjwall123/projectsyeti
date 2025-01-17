
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:projectsyeti/features/auth/data/model/auth_hive_model.dart';

class HiveService {
  static Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}/projectsyeti2.db';

    Hive.init(path);//initializing database

    Hive.registerAdapter(UserHiveModelAdapter());//creates box(table) in the database
  }


  Future<void> addUser(UserHiveModel user) async {
    var box = await Hive.openBox<UserHiveModel>('userBox');//openbox is responsible for reading row of the table
    await box.put(user.id, user);
  }

  Future<void> deleteUser(String id) async {
    var box = await Hive.openBox<UserHiveModel>('userBox');
    await box.delete(id);
  }

  Future<List<UserHiveModel>> getAllUsers() async {
    var box = await Hive.openBox<UserHiveModel>('userBox');
    return box.values.toList();
  }

  Future<UserHiveModel?> login(String email, String password) async {
    var box = await Hive.openBox<UserHiveModel>('userBox');
    try {
      return box.values.firstWhere(
        (user) => user.email == email && user.password == password,
      );
    } catch (e) {
      return null; 
    }
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk('userBox');
  }

  Future<void> clearUserBox() async {
    await Hive.deleteBoxFromDisk('userBox');
  }

  Future<void> close() async {
    await Hive.close();
  }
}
