import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:projectsyeti/features/experience/domain/entity/experience_entity.dart';

part 'experience_api_model.g.dart';

@JsonSerializable()
class ExperienceApiModel extends Equatable {
  final String title;
  final String company;
  final int from;
  final int to;
  final String description;

  const ExperienceApiModel({
    required this.title,
    required this.company,
    required this.from,
    required this.to,
    required this.description,
  });

  factory ExperienceApiModel.fromJson(Map<String, dynamic> json) =>
      _$ExperienceApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceApiModelToJson(this);

  ExperienceEntity toEntity() {
    return ExperienceEntity(
      title: title,
      company: company,
      from: from,
      to: to,
      description: description,
    );
  }

  factory ExperienceApiModel.fromEntity(ExperienceEntity entity) {
    return ExperienceApiModel(
      title: entity.title,
      company: entity.company,
      from: entity.from,
      to: entity.to,
      description: entity.description,
    );
  }

  @override
  List<Object?> get props => [title, company, from, to, description];
}
