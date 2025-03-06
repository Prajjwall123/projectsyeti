import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:projectsyeti/features/company/domain/entity/company_entity.dart';

part 'company_api_model.g.dart';

@JsonSerializable()
class CompanyApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
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

  const CompanyApiModel({
    this.id,
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

  factory CompanyApiModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyApiModelToJson(this);

  CompanyEntity toEntity() {
    return CompanyEntity(
      userId: id,
      companyName: companyName,
      companyBio: companyBio,
      employees: employees,
      logo: logo,
      projectsPosted: projectsPosted,
      projectsAwarded: projectsAwarded,
      projectsCompleted: projectsCompleted,
      founded: founded,
      ceo: ceo,
      headquarters: headquarters,
      industry: industry,
      website: website,
    );
  }

  factory CompanyApiModel.fromEntity(CompanyEntity entity) {
    return CompanyApiModel(
      id: entity.userId,
      companyName: entity.companyName,
      companyBio: entity.companyBio,
      employees: entity.employees,
      logo: entity.logo,
      projectsPosted: entity.projectsPosted,
      projectsAwarded: entity.projectsAwarded,
      projectsCompleted: entity.projectsCompleted,
      founded: entity.founded,
      ceo: entity.ceo,
      headquarters: entity.headquarters,
      industry: entity.industry,
      website: entity.website,
    );
  }

  @override
  List<Object?> get props => [
        id,
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
