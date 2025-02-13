part of 'company_bloc.dart';

sealed class CompanyEvent extends Equatable {
  const CompanyEvent();

  @override
  List<Object?> get props => [];
}

final class GetCompanyByIdEvent extends CompanyEvent {
  final String companyId;

  const GetCompanyByIdEvent(this.companyId);

  @override
  List<Object?> get props => [companyId];
}
