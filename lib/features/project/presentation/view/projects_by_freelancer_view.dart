import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectsyeti/app/di/di.dart';
import 'package:projectsyeti/features/project/domain/entity/project_entity.dart';
import 'package:projectsyeti/features/project/presentation/view_model/bloc/project_bloc.dart';

class ProjectsByFreelancerView extends StatefulWidget {
  final String freelancerId;

  const ProjectsByFreelancerView({super.key, required this.freelancerId});

  @override
  _ProjectsByFreelancerViewState createState() =>
      _ProjectsByFreelancerViewState();
}

class _ProjectsByFreelancerViewState extends State<ProjectsByFreelancerView> {
  List<ProjectEntity> projects = [];

  @override
  void initState() {
    super.initState();
    context
        .read<ProjectBloc>()
        .add(GetProjectsByFreelancerIdEvent(widget.freelancerId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Freelancer Projects')),
      body: SafeArea(
        child: BlocBuilder<ProjectBloc, ProjectState>(
          builder: (context, state) {
            if (state is ProjectLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProjectsLoaded) {
              projects = state.projects;
              return _buildProjectTable();
            } else if (state is ProjectError) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return const Center(child: Text("No Data Available"));
          },
        ),
      ),
    );
  }

  Widget _buildProjectTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Allows horizontal scrolling if needed
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: DataTable(
            border: TableBorder.all(color: Colors.grey.shade300),
            columns: const [
              DataColumn(label: Text("Project Title")),
              DataColumn(label: Text("Status")),
              DataColumn(label: Text("Duration")),
              DataColumn(label: Text("Actions")),
            ],
            rows: projects.map((project) {
              return DataRow(cells: [
                DataCell(Text(project.title)),
                DataCell(_buildStatusChip(project.status)),
                DataCell(Text("${project.duration} months")),
                DataCell(ElevatedButton(
                  onPressed: () => _viewDetails(project),
                  child: const Text("View"),
                )),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case "awarded":
        color = Colors.orange;
        break;
      case "in progress":
        color = Colors.red;
        break;
      case "feedback requested":
        color = Colors.blue;
        break;
      case "completed":
        color = Colors.green;
        break;
      default:
        color = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _viewDetails(ProjectEntity project) {
    // TODO: Implement navigation to project details
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Viewing details for ${project.title}")),
    );
  }
}
