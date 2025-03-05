import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projectsyeti/app/constants/hive_table_constant.dart';
import 'package:projectsyeti/features/project/data/model/project_hive_model.dart';

class HiveService {
  Future<void> addProject(ProjectHiveModel project) async {
    var box =
        await Hive.openBox<ProjectHiveModel>(HiveTableConstant.projectBox);
    await box.put(project.id, project);
    debugPrint("Added project with ID: ${project.id} to Hive");
  }

  Future<void> deleteProject(String projectId) async {
    var box =
        await Hive.openBox<ProjectHiveModel>(HiveTableConstant.projectBox);
    await box.delete(projectId);
    debugPrint("Deleted project with ID: $projectId from Hive");
  }

  Future<List<ProjectHiveModel>> getAllProjects() async {
    var box =
        await Hive.openBox<ProjectHiveModel>(HiveTableConstant.projectBox);
    debugPrint("Fetching all projects from Hive, total count: ${box.length}");
    return box.values.toList();
  }

  Future<ProjectHiveModel?> getProjectById(String projectId) async {
    var box =
        await Hive.openBox<ProjectHiveModel>(HiveTableConstant.projectBox);
    debugPrint("Fetching project with ID: $projectId from Hive");
    return box.get(projectId);
  }

  Future<List<ProjectHiveModel>> getProjectsByFreelancerId(
      String freelancerId) async {
    var box =
        await Hive.openBox<ProjectHiveModel>(HiveTableConstant.projectBox);
    debugPrint("Fetching projects for freelancer ID: $freelancerId from Hive");
    return box.values
        .where((project) => project.awardedTo == freelancerId)
        .toList();
  }

  Future<void> updateProject(ProjectHiveModel project) async {
    var box =
        await Hive.openBox<ProjectHiveModel>(HiveTableConstant.projectBox);
    debugPrint("Updating project with ID: ${project.id} in Hive");
    await box.put(project.id!, project);
    debugPrint("Successfully updated project with ID: ${project.id} in Hive");
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.projectBox);
    debugPrint("Cleared all projects from Hive");
  }

  Future<void> clearProjectBox() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.projectBox);
    debugPrint("Cleared project box from Hive");
  }

  Future<void> close() async {
    await Hive.close();
    debugPrint("Hive closed");
  }
}
