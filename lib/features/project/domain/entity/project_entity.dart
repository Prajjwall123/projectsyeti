import 'package:equatable/equatable.dart';

class ProjectEntity extends Equatable {
  final String? projectId;
  final String companyId;
  final String companyName;
  final String companyLogo;
  final String title;
  final List<String> category;
  final String requirements;
  final String description;
  final String duration;
  final DateTime postedDate;
  final String status;

  const ProjectEntity({
    this.projectId,
    required this.companyId,
    required this.companyName,
    required this.companyLogo,
    required this.title,
    required this.category,
    required this.requirements,
    required this.description,
    required this.duration,
    required this.postedDate,
    required this.status,
  });

  ProjectEntity copyWith({
    String? projectId,
    String? companyId,
    String? companyName,
    String? companyLogo,
    String? title,
    List<String>? category,
    String? requirements,
    String? description,
    String? duration,
    DateTime? postedDate,
    String? status,
  }) {
    return ProjectEntity(
      projectId: projectId ?? this.projectId,
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      companyLogo: companyLogo ?? this.companyLogo,
      title: title ?? this.title,
      category: category ?? this.category,
      requirements: requirements ?? this.requirements,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      postedDate: postedDate ?? this.postedDate,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        projectId,
        companyId,
        companyName,
        companyLogo,
        title,
        category,
        requirements,
        description,
        duration,
        postedDate,
        status,
      ];
}
