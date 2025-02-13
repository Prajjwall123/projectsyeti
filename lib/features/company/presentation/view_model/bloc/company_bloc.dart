import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/company/domain/entity/company_entity.dart';
import 'package:projectsyeti/features/company/domain/use_case/get_company_by_id_usecase.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final GetCompanyByIdUseCase getCompanyByIdUseCase;

  CompanyBloc(this.getCompanyByIdUseCase) : super(CompanyInitial()) {
    on<GetCompanyByIdEvent>(_onGetCompanyById);
  }

  Future<void> _onGetCompanyById(
    GetCompanyByIdEvent event,
    Emitter<CompanyState> emit,
  ) async {
    emit(CompanyLoading());
    final Either<Failure, CompanyEntity> result = await getCompanyByIdUseCase(
        GetCompanyByIdParams(companyId: event.companyId));

    result.fold(
      (failure) => emit(CompanyError(_mapFailureToMessage(failure))),
      (company) => emit(CompanyLoaded(company)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ApiFailure) {
      return failure.message ?? 'An unexpected error occurred';
    }
    return 'An unexpected error occurred';
  }
}
