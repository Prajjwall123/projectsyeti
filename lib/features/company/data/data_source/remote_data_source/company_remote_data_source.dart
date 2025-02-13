import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projectsyeti/app/constants/api_endpoints.dart';
import 'package:projectsyeti/features/company/data/data_source/company_data_source.dart';
import 'package:projectsyeti/features/company/domain/entity/company_entity.dart';

class CompanyRemoteDataSource implements ICompanyDataSource {
  final Dio _dio;

  CompanyRemoteDataSource(this._dio);

  @override
  Future<CompanyEntity> getCompanyById(String companyId) async {
    try {
      Response response =
          await _dio.get('${ApiEndpoints.getCompanyById}/$companyId');
      debugPrint("Sent GET request for company by ID: $companyId");

      if (response.statusCode == 200) {
        final data = response.data;

        return CompanyEntity(
          userId: data['_id'],
          companyName: data['companyName'] ?? '',
          companyBio: data['companyBio'],
          employees: data['employees'] ?? 0,
          logo: data['logo'],
          projectsPosted: data['projectsPosted'] ?? 0,
          projectsAwarded: data['projectsAwarded'] ?? 0,
          projectsCompleted: data['projectsCompleted'] ?? 0,
          founded: data['founded'],
          ceo: data['ceo'],
          headquarters: data['headquarters'],
          industry: data['industry'],
          website: data['website'],
        );
      } else {
        throw Exception(response.data['message'] ?? 'Failed to fetch company');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
