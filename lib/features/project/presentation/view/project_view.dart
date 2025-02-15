import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectsyeti/features/project/domain/entity/project_entity.dart';
import 'package:projectsyeti/features/project/presentation/view_model/bloc/project_bloc.dart';

class ProjectView extends StatefulWidget {
  final String projectId;

  const ProjectView({super.key, required this.projectId});

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
  @override
  void initState() {
    super.initState();
    context.read<ProjectBloc>().add(GetProjectByIdEvent(widget.projectId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ProjectBloc, ProjectState>(
          builder: (context, state) {
            if (state is ProjectLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProjectLoaded) {
              return _buildProjectDetails(state.project);
            } else if (state is ProjectError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red, fontSize: 18),
                ),
              );
            }
            return const Center(child: Text("No Project Data Available"));
          },
        ),
      ),
    );
  }

  Widget _buildProjectDetails(ProjectEntity project) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildDetailRow("Title", project.title),
          _buildDetailRow("Company Name", project.companyName),
          // _buildDetailRow("Company ID", project.companyId),
          const SizedBox(height: 10),
          if (project.companyLogo.isNotEmpty)
            Center(
              child: Image.network(
                "http://10.0.2.2:3000/${project.companyLogo}",
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 20),
          _buildDetailRow("Requirements", project.requirements),
          _buildDetailRow("Description", project.description),
          _buildDetailRow("Duration", "${project.duration} months"),
          _buildDetailRow("Status", project.status),
          _buildDetailRow(
            "Posted Date",
            project.postedDate.toLocal().toString().split(' ')[0],
          ),
          const SizedBox(height: 20),
          _buildSkillList(project.category),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillList(List<String> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Skills Required:",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        ...skills.map((skill) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, size: 16, color: Colors.green),
                  const SizedBox(width: 8),
                  Text(skill, style: const TextStyle(fontSize: 16)),
                ],
              ),
            )),
      ],
    );
  }
}
