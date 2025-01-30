import 'package:flutter/material.dart';
import 'package:projectsyeti/app/constants/api_endpoints.dart';
import 'package:projectsyeti/features/auth/data/data_source/auth_data_source.dart';
import 'package:projectsyeti/features/auth/domain/entity/auth_entity.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSource implements IAuthDataSource {
  final Dio _dio;
  AuthRemoteDataSource(this._dio);

  @override
  Future<AuthEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      // Sending a POST
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      debugPrint("sent the post request");

      //
      if (response.statusCode == 200) {
        return response.data['token'];
      } else {
        throw Exception(response.data['message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    } catch (e) {
      throw Exception('An error required in $e');
    }
  }

  @override
  Future<void> registerStudent(AuthEntity student) {
    // TODO: implement registerStudent
    throw UnimplementedError();
  }
}
