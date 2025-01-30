import 'package:equatable/equatable.dart';

class SkillEntity extends Equatable {
  final String? skillId;
  final String skillName;

  const SkillEntity({
    this.skillId,
    required this.skillName,
  });

  @override
  List<Object?> get props => [skillId, skillName];
}
