import '../../domain/entity/project_entity.dart';

abstract interface class IProjectDataSource {
  Future<List<ProjectEntity>> getAllProjects();

  Future<ProjectEntity> getProjectById(String projectId);
}
