import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:projectsyeti/app/constants/hive_table_constant.dart';
import 'package:projectsyeti/features/project/domain/entity/project_entity.dart';
import 'package:uuid/uuid.dart';

part 'project_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.projectTableId)
class ProjectHiveModel extends Equatable {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String companyId;

  @HiveField(2)
  final String companyName;

  @HiveField(3)
  final String companyLogo;

  @HiveField(4)
  final String? headquarters;

  @HiveField(5)
  final String title;

  @HiveField(6)
  final List<String> category;

  @HiveField(7)
  final String requirements;

  @HiveField(8)
  final String description;

  @HiveField(9)
  final String duration;

  @HiveField(10)
  final DateTime postedDate;

  @HiveField(11)
  final String status;

  @HiveField(12)
  final int bidCount;

  @HiveField(13)
  final String? awardedTo;

  @HiveField(14)
  final String? feedbackRequestedMessage;

  @HiveField(15)
  final String? link;

  @HiveField(16)
  final String? feedbackRespondMessage;

  ProjectHiveModel({
    String? id,
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
  }) : id = id ?? const Uuid().v4();

  // Initial Constructor
  ProjectHiveModel.initial()
      : id = '',
        companyId = '',
        companyName = '',
        companyLogo = '',
        headquarters = '',
        title = '',
        category = [],
        requirements = '',
        description = '',
        duration = '',
        postedDate = DateTime.now(),
        status = '',
        bidCount = 0,
        awardedTo = '',
        feedbackRequestedMessage = '',
        link = '',
        feedbackRespondMessage = '';

  // From JSON
  factory ProjectHiveModel.fromJson(Map<String, dynamic> json) {
    return ProjectHiveModel(
      id: json['projectId'] as String?,
      companyId: json['companyId'] as String,
      companyName: json['companyName'] as String,
      companyLogo: json['companyLogo'] as String,
      headquarters: json['headquarters'] as String?,
      title: json['title'] as String,
      category: (json['category'] as List<dynamic>).cast<String>(),
      requirements: json['requirements'] as String,
      description: json['description'] as String,
      duration: json['duration'] as String,
      postedDate: DateTime.parse(json['postedDate'] as String),
      status: json['status'] as String,
      bidCount: json['bidCount'] as int,
      awardedTo: json['awardedTo'] as String?,
      feedbackRequestedMessage: json['feedbackRequestedMessage'] as String?,
      link: json['link'] as String?,
      feedbackRespondMessage: json['feedbackRespondMessage'] as String?,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'projectId': id,
      'companyId': companyId,
      'companyName': companyName,
      'companyLogo': companyLogo,
      'headquarters': headquarters,
      'title': title,
      'category': category,
      'requirements': requirements,
      'description': description,
      'duration': duration,
      'postedDate': postedDate.toIso8601String(),
      'status': status,
      'bidCount': bidCount,
      'awardedTo': awardedTo,
      'feedbackRequestedMessage': feedbackRequestedMessage,
      'link': link,
      'feedbackRespondMessage': feedbackRespondMessage,
    };
  }

  // To Entity
  ProjectEntity toEntity() {
    return ProjectEntity(
      projectId: id,
      companyId: companyId,
      companyName: companyName,
      companyLogo: companyLogo,
      headquarters: headquarters,
      title: title,
      category: category,
      requirements: requirements,
      description: description,
      duration: duration,
      postedDate: postedDate,
      status: status,
      bidCount: bidCount,
      awardedTo: awardedTo,
      feedbackRequestedMessage: feedbackRequestedMessage,
      link: link,
      feedbackRespondMessage: feedbackRespondMessage,
    );
  }

  @override
  List<Object?> get props => [
        id,
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
        feedbackRespondMessage,
      ];
}