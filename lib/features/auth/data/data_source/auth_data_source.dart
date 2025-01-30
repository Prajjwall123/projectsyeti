import 'dart:io';

import '../../domain/entity/auth_entity.dart';

abstract interface class IAuthDataSource {
  Future<String> loginUser(String email, String password);

  Future<void> registerStudent(AuthEntity student);

  Future<AuthEntity> getCurrentUser();
}
