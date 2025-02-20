import 'package:flutter/material.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';

class MyTag extends StatelessWidget {
  final SkillEntity skill;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  const MyTag({
    super.key,
    required this.skill,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        skill.name,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
