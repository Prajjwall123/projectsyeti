import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:projectsyeti/features/certification/domain/entity/certification_entity.dart';

part 'certification_api_model.g.dart';

@JsonSerializable()
class CertificationApiModel extends Equatable {
  final String name;
  final String organization;

  const CertificationApiModel({
    required this.name,
    required this.organization,
  });

  factory CertificationApiModel.fromJson(Map<String, dynamic> json) =>
      _$CertificationApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CertificationApiModelToJson(this);

  CertificationEntity toEntity() {
    return CertificationEntity(
      name: name,
      organization: organization,
    );
  }

  factory CertificationApiModel.fromEntity(CertificationEntity entity) {
    return CertificationApiModel(
      name: entity.name,
      organization: entity.organization,
    );
  }

  @override
  List<Object?> get props => [name, organization];
}
