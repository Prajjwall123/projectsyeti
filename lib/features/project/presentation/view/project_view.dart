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
          // Project Title
          Text(
            project.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // Company Name and Logo
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: project.companyLogo.isNotEmpty
                    ? NetworkImage("http://10.0.2.2:3000/${project.companyLogo}")
                    : const AssetImage("assets/images/default_company.png")
                        as ImageProvider,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  project.companyName,
                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Description
          Text(
            project.description,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const SizedBox(height: 20),

          // Detail Cards (Posted Date, Duration, Status)
          Row(
            children: [
              Expanded(child: _buildDetailCard(Icons.calendar_today, "Posted Date", _formatDate(project.postedDate))),
              const SizedBox(width: 8),
              Expanded(child: _buildDetailCard(Icons.work, "Duration", "${project.duration} months")),
            ],
          ),
          const SizedBox(height: 8),
          _buildDetailCard(Icons.check_circle, "Status", project.status),

          const SizedBox(height: 20),

          // Skills Section
          _buildSkillSection(project.category),

          const SizedBox(height: 20),

          // Requirements Section
          const Text(
            "Requirements",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...project.requirements.split('\n').map(
                (requirement) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_right, size: 20, color: Colors.black54),
                      const SizedBox(width: 8),
                      Expanded(child: Text(requirement.trim())),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blue),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 14, color: Colors.black54)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillSection(List<String> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Categories:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills.map((skill) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                skill,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
