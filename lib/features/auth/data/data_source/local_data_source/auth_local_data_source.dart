// import 'package:projectsyeti/features/auth/data/model/auth_hive_model.dart';
// import 'package:projectsyeti/features/auth/domain/entity/auth_entity.dart';

// import '../../../../../core/network/hive_service.dart';
// import '../auth_data_source.dart';

// class AuthLocalDataSource implements IAuthDataSource {
//   final HiveService _hiveService;

//   AuthLocalDataSource(this._hiveService);

//   @override
//   Future<AuthEntity> getCurrentUser() {
//     return Future.value(AuthEntity(
//       id: "1",
//       email: "",
//       password: "",
//       phone: "",
//       fname: "",
//     ));
//   }

//   @override
//   Future<String> loginUser(String email, String password) async {
//     try {
//       final user = await _hiveService.login(email, password);
//       if (user != null) {
//         return Future.value("Success");
//       } else {
//         return Future.error("Invalid credentials");
//       }
//     } catch (e) {
//       return Future.error(e);
//     }
//   }

//   @override
//   Future<void> registerStudent(AuthEntity user) async {
//     try {
//       final userHiveModel = UserHiveModel(
//         id: user.id,
//         email: user.email,
//         password: user.password,
//         fname: user.fname,
//         phone: user.phone,
//       );

//       await _hiveService.addUser(userHiveModel);
//       return Future.value();
//     } catch (e) {
//       return Future.error(e);
//     }
//   }
// }
