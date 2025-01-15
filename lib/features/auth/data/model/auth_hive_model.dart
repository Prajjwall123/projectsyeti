import 'package:hive/hive.dart';
import 'package:projectsyeti/app/constants/hive_table_constant.dart';
import 'package:projectsyeti/features/auth/domain/entity/auth_entity.dart';
import 'package:uuid/uuid.dart';

@HiveType(typeId: HiveTableConstant.authTableId)
class AuthHiveModel {
  @HiveField(0)
  final String? userId;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String password;

  AuthHiveModel({
    String? userId,
    required this.email,
    required this.password,
  }) : userId = userId ?? const Uuid().v4();

  //initial constructor
  const AuthHiveModel.intial()
      : userId = '',
        email = '',
        password = '';

  //from entity- top to bottom
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      userId: entity.userId,
      email: entity.email,
      password: entity.password,
    );
  }

  //to entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: userId,
      email: email,
      password: password,
    );
  }

  @override
  List<Object?> get props => [userId];
}
