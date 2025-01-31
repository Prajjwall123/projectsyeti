import 'package:equatable/equatable.dart';

class SkillEntity extends Equatable {
  final String? skillId;
  final String name;

  const SkillEntity({
    this.skillId,
    required this.name,
  });

  @override
  List<Object?> get props => [skillId, name];
}
