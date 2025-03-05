import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';

class SkillTestData {
  SkillTestData._();

  static List<SkillEntity> getSkillTestData() {
    List<SkillEntity> lstlstSkills = [
      const SkillEntity(
        skillId: "679b4fbb7dbeac15d47c7cdb",
        name: "React",
      ),
      const SkillEntity(
        skillId: "679b4fdc7dbeac15d47c7cde",
        name: "Java",
      ),
      const SkillEntity(
        skillId: "679b4fe07dbeac15d47c7ce1",
        name: "Flutter",
      ),
    ];

    return lstlstSkills;
  }
}
