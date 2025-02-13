part of 'company_bloc.dart';

sealed class CompanyState extends Equatable {
  const CompanyState();

  @override
  List<Object?> get props => [];
}

final class CompanyInitial extends CompanyState {}

final class CompanyLoading extends CompanyState {}

final class CompanyLoaded extends CompanyState {
  final CompanyEntity company;

  const CompanyLoaded(this.company);

  @override
  List<Object?> get props => [company];
}

final class CompanyError extends CompanyState {
  final String message;

  const CompanyError(this.message);

  @override
  List<Object?> get props => [message];
}
