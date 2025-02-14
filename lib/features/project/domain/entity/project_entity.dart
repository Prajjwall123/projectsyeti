import 'package:equatable/equatable.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';

class ProjectEntity extends Equatable {
  final String? projectId;
  final String companyId;
  final String title;
  final List<SkillEntity> category;
  final String requirements;
  final String description;
  final String duration;
  final DateTime postedDate;
  final String status;

  const ProjectEntity({
    this.projectId,
    required this.companyId,
    required this.title,
    required this.category,
    required this.requirements,
    required this.description,
    required this.duration,
    required this.postedDate,
    required this.status,
  });

  @override
  List<Object?> get props => [
        projectId,
        companyId,
        title,
        category,
        requirements,
        description,
        duration,
        postedDate,
        status,
      ];
}
