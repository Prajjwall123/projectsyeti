import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:projectsyeti/features/auth/domain/entity/auth_entity.dart';
import 'package:projectsyeti/features/skill/data/model/skill_api_model.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable{
  @JsonKey(name: '_id')
  final String? id;
  final String freelancerName;
  final String? profileImage;
  final List<SkillApiModel> skills;
  final String email;
  final String password;
  final String? portfolio;
  final String? availability;
  final int? experienceYears;

  const AuthApiModel({
    this.id,
    required this.freelancerName,
     this.portfolio,
    this.profileImage,
    required this.email,
    required this.password,
    required this.skills,
     this.availability,
     this.experienceYears,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: id,
      freelancerName: freelancerName,
      portfolio: portfolio,
      profileImage: profileImage,
      email: email,
      experienceYears:experienceYears,
      skills: skills.map((e) => e.toEntity()).toList(),
      availability: availability,
      password: password ?? '',
    );
  }

  // From Entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      freelancerName: entity.freelancerName,
      portfolio: entity.portfolio,
      profileImage: entity.profileImage,
      email: entity.email,
      skills: entity.skills.map((e) => SkillApiModel.fromEntity(e)).toList(),
      availability: entity.availability,
      experienceYears: entity.experienceYears,
      password: entity.password,
    );
  }

   @override
  List<Object?> get props =>
      [id, freelancerName, portfolio, profileImage, email, skills, availability, experienceYears, password];
}