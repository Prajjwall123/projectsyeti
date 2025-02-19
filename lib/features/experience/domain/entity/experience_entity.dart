import 'package:equatable/equatable.dart';

class ExperienceEntity extends Equatable {
  final String title;
  final String company;
  final int from;
  final int to;
  final String description;

  const ExperienceEntity({
    required this.title,
    required this.company,
    required this.from,
    required this.to,
    required this.description,
  });

  @override
  List<Object> get props => [title, company, from, to, description];

  ExperienceEntity copyWith({
    String? title,
    String? company,
    int? from,
    int? to,
    String? description,
  }) {
    return ExperienceEntity(
      title: title ?? this.title,
      company: company ?? this.company,
      from: from ?? this.from,
      to: to ?? this.to,
      description: description ?? this.description,
    );
  }
}
