import '../../domain/entity/company_entity.dart';

abstract interface class ICompanyDataSource {
  Future<CompanyEntity> getCompanyById(String companyId);
}
