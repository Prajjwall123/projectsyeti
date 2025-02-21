import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projectsyeti/app/constants/api_endpoints.dart';
import 'package:projectsyeti/features/bidding/data/data_source/bidding_data_source.dart';
import 'package:projectsyeti/features/bidding/domain/entity/bidding_entity.dart';

class BiddingRemoteDataSource implements IBiddingDataSource {
  final Dio _dio;

  BiddingRemoteDataSource(this._dio);

  @override
  Future<void> createBid(BiddingEntity bid, File file) async {
    try {
      // Create FormData to send the bid details and the file
      FormData formData = FormData.fromMap({
        "freelancer": bid.freelancerId,
        "project": bid.projectId,
        "amount": bid.amount,
        "message": bid.message,
        "file": await MultipartFile.fromFile(file.path, filename: file.uri.pathSegments.last), // File upload
      });

      // Send the request
      Response response = await _dio.post(
        ApiEndpoints.createBid,
        data: formData,
      );

      if (response.statusCode == 200) {
        debugPrint("Bid created successfully");
      } else {
        throw Exception(response.data['message'] ?? 'Failed to create bid');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
