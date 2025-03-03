import 'package:equatable/equatable.dart';

class ProjectEntity extends Equatable {
  final String? projectId;
  final String companyId;
  final String companyName;
  final String companyLogo;
  final String? headquarters;
  final String title;
  final List<String> category;
  final String requirements;
  final String description;
  final String duration;
  final DateTime postedDate;
  final String status;
  final int bidCount;
  final String? awardedTo;
  final String? feedbackRequestedMessage;
  final String? link;
  final String? feedbackRespondMessage;

  const ProjectEntity({
    this.projectId,
    required this.companyId,
    required this.companyName,
    required this.companyLogo,
     this.headquarters,
    required this.title,
    required this.category,
    required this.requirements,
    required this.description,
    required this.duration,
    required this.postedDate,
    required this.status,
    required this.bidCount,
    this.awardedTo,
    this.feedbackRequestedMessage,
    this.link,
    this.feedbackRespondMessage,
  });

  ProjectEntity copyWith({
    String? projectId,
    String? companyId,
    String? companyName,
    String? companyLogo,
    String? title,
    String? headquarters,
    List<String>? category,
    String? requirements,
    String? description,
    String? duration,
    DateTime? postedDate,
    String? status,
    int? bidCount,
    String? awardedTo,
    String? feedbackRequestedMessage,
    String? link,
    String? feedbackRespondMessage,
  }) {
    return ProjectEntity(
      projectId: projectId ?? this.projectId,
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      companyLogo: companyLogo ?? this.companyLogo,
      headquarters: headquarters ?? this.headquarters,
      title: title ?? this.title,
      category: category ?? this.category,
      requirements: requirements ?? this.requirements,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      postedDate: postedDate ?? this.postedDate,
      status: status ?? this.status,
      bidCount: bidCount ?? this.bidCount,
      awardedTo: awardedTo ?? this.awardedTo,
      feedbackRequestedMessage:
          feedbackRequestedMessage ?? this.feedbackRequestedMessage,
      link: link ?? this.link,
      feedbackRespondMessage:
          feedbackRespondMessage ?? this.feedbackRespondMessage,
    );
  }

  @override
  List<Object?> get props => [
        projectId,
        companyId,
        companyName,
        companyLogo,
        headquarters,
        title,
        category,
        requirements,
        description,
        duration,
        postedDate,
        status,
        bidCount,
        awardedTo,
        feedbackRequestedMessage,
        link,
        feedbackRespondMessage
      ];
}
