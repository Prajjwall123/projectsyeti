import 'package:dartz/dartz.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/company/domain/entity/company_entity.dart';

abstract interface class ICompanyRepository {
  Future<Either<Failure, CompanyEntity>> getCompanyById(String companyId);
}
