import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/company/data/data_source/remote_data_source/company_remote_data_source.dart';
import 'package:projectsyeti/features/company/domain/entity/company_entity.dart';
import 'package:projectsyeti/features/company/domain/entity/repository/company_repository.dart';

class CompanyRemoteRepository implements ICompanyRepository {
  final CompanyRemoteDataSource _companyRemoteDataSource;

  CompanyRemoteRepository(this._companyRemoteDataSource);

  @override
  Future<Either<Failure, CompanyEntity>> getCompanyById(
      String companyId) async {
    try {
      final company = await _companyRemoteDataSource.getCompanyById(companyId);
      return Right(company);
    } catch (e) {
      debugPrint("Error fetching company by ID: $e");
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
