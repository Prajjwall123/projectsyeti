import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:projectsyeti/app/constants/hive_table_constant.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class UserHiveModel extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String password;
  @HiveField(3)
  final String fname;
  @HiveField(4)
  final String phone;

  UserHiveModel({
    String? id,
    required this.email,
    required this.password,
    required this.fname,
    required this.phone,
  }) : id = id ?? const Uuid().v4();

  // Initial Constructor
  const UserHiveModel.initial()
      : id = '',
        email = '',
        password = '',
        fname = '',
        phone = '';

  // From Entity
  factory UserHiveModel.fromJson(Map<String, dynamic> json) {
    return UserHiveModel(
      id: json['id'] as String?,
      email: json['email'] as String,
      password: json['password'] as String,
      fname: json['fname'] as String,
      phone: json['phone'] as String,
    );
  }

  // To Entity
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'fname': fname,
      'phone': phone,
    };
  }

  @override
  List<Object?> get props => [id, email, password, fname, phone];
}
