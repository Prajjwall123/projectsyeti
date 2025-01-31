import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';

abstract interface class ISkillDataSource {
  Future<List<SkillEntity>> getSkills();
  Future<void> createSkill(SkillEntity skill);
  Future<void> deleteSkill(String id);
}
