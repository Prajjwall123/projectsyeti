import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:projectsyeti/app/usecase/usecase.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/company/domain/entity/company_entity.dart';
import 'package:projectsyeti/features/company/domain/entity/repository/company_repository.dart';

class GetCompanyByIdParams extends Equatable {
  final String companyId;

  const GetCompanyByIdParams({required this.companyId});

  @override
  List<Object?> get props => [companyId];
}

class GetCompanyByIdUseCase
    implements UsecaseWithParams<CompanyEntity, GetCompanyByIdParams> {
  final ICompanyRepository repository;

  GetCompanyByIdUseCase(this.repository);

  @override
  Future<Either<Failure, CompanyEntity>> call(GetCompanyByIdParams params) {
    return repository.getCompanyById(params.companyId);
  }
}
