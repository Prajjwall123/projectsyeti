import 'package:equatable/equatable.dart';

class CompanyEntity extends Equatable {
  final String? userId;
  final String companyName;
  final String? companyBio;
  final int employees;
  final String? logo;
  final int projectsPosted;
  final int projectsAwarded;
  final int projectsCompleted;
  final int? founded;
  final String? ceo;
  final String? headquarters;
  final String? industry;
  final String? website;

  const CompanyEntity({
    this.userId,
    required this.companyName,
    this.companyBio,
    required this.employees,
    this.logo,
    required this.projectsPosted,
    required this.projectsAwarded,
    required this.projectsCompleted,
    this.founded,
    this.ceo,
    this.headquarters,
    this.industry,
    this.website,
  });

  const CompanyEntity.empty()
      : userId = null,
        companyName = '',
        companyBio = null,
        employees = 0,
        logo = null,
        projectsPosted = 0,
        projectsAwarded = 0,
        projectsCompleted = 0,
        founded = null,
        ceo = null,
        headquarters = null,
        industry = null,
        website = null;

  @override
  List<Object?> get props => [
        userId,
        companyName,
        companyBio,
        employees,
        logo,
        projectsPosted,
        projectsAwarded,
        projectsCompleted,
        founded,
        ceo,
        headquarters,
        industry,
        website,
      ];
}
