import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:projectsyeti/app/usecase/usecase.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';
import 'package:projectsyeti/features/skill/domain/repository/skill_repository.dart';

class GetAllSkillsUsecase implements UsecaseWithoutParams<List<SkillEntity>> {
  final ISkillRepository _skillRepository;
  GetAllSkillsUsecase({required ISkillRepository skillRepository})
      : _skillRepository = skillRepository;

  @override
  Future<Either<Failure, List<SkillEntity>>> call() {
    return _skillRepository.getSkills();
  }
}
