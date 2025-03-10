import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projectsyeti/app/constants/api_endpoints.dart';
import 'package:projectsyeti/features/notification/data/data_source/notification_data_source.dart';
import 'package:projectsyeti/features/notification/data/model/notification_api_model.dart';
import 'package:projectsyeti/features/notification/domain/entity/notification_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationRemoteDataSource implements INotificationDataSource {
  final Dio _dio;

  NotificationRemoteDataSource(Dio dio) : _dio = dio;

  @override
  Future<List<NotificationEntity>> getNotificationByFreelancerId(
      String freelancerId) async {
    try {
      var response = await _dio.get(
          '${ApiEndpoints.getNotificationByFreelancer}/$freelancerId/Freelancer');

      if (response.statusCode == 200) {
        List<dynamic> notificationsJson = response.data;
        return notificationsJson
            .map((json) => NotificationApiModel.fromJson(json).toEntity())
            .toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  @override
  Future<String> seenNotificationByFreelancerId(String notificationId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token == null) {
        throw Exception('Token is missing');
      }

      var response = await _dio.put(
        '${ApiEndpoints.seenNotificationByFreelancerId}/$notificationId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      debugPrint(
          "Response from seenNotificationByFreelancerId: ${response.data}");

      if (response.statusCode == 200) {
        return "Marked as read";
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    } catch (e) {
      throw Exception('Error updating notification: $e');
    }
  }
}
