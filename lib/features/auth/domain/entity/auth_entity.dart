import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class AuthEntity extends Equatable {
  final String id;
  final String email;
  final String password;
  final String fname;
  final String phone;

  AuthEntity({
    String? id,
    required this.email,
    required this.password,
    required this.fname,
    required this.phone,
  }) : id = id ?? const Uuid().v4();

  @override
  List<Object> get props => [id, email, password, fname, phone];
}
