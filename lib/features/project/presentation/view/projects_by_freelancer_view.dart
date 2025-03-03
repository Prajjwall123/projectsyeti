import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Your Projects'),
      ),
      body: SafeArea(
        child: BlocBuilder<ProjectBloc, ProjectState>(
          builder: (context, state) {
            if (state is ProjectLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProjectsLoaded) {
              projects = state.projects;
              return _buildProjectList();
            } else if (state is ProjectError) {
              return Center(
                child: Text(
                  "Error: ${state.message}",
                  style: TextStyle(
                    color: theme.colorScheme.error,
                    fontSize: 18,
                  ),
                ),
              );
            }
            return const Center(child: Text("No Projects Available"));
          },
        ),
      ),
    );
  }

  Widget _buildProjectList() {
    final theme = Theme.of(context);
    final isDarkTheme =
        theme.brightness == Brightness.dark; // Define isDarkTheme here
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    const double navBarHeight = 56.0;

    return ListView.builder(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
        bottom: bottomPadding + navBarHeight + 20,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.only(bottom: 16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project Title
                Text(
                  "Project",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  project.title,
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 12),

                // Company
                Text(
                  "Company",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  project.companyName,
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 12),

                // Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Status",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color:
                            isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                    _buildStatusDropdown(project),
                  ],
                ),
                const SizedBox(height: 16),

                // Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildActionButton(
                      label: "Show Feedback",
                      color: theme.colorScheme.primary,
                      onPressed: () => _showFeedback(project),
                    ),
                    const SizedBox(width: 8),
                    _buildActionButton(
                      label: "View Details",
                      color: Colors.green,
                      onPressed: () => _viewDetails(project),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusDropdown(ProjectEntity project) {
    final theme = Theme.of(context);
    final statuses = [
      "To Do",
      "In Progress",
      "Feedback Requested",
      "Done",
    ];

    return DropdownButton<String>(
      value: project.status,
      isDense: true,
      items: statuses.map((status) {
        return DropdownMenuItem<String>(
          value: status,
          child: Text(
            status,
            style: theme.textTheme.bodyMedium,
            softWrap: true,
          ),
        );
      }).toList(),
      onChanged: (newStatus) {
        if (newStatus != null && newStatus != project.status) {
          if (newStatus == "Feedback Requested") {
            _showFeedbackModal(project);
          }
        }
      },
    );
  }

  Widget _buildActionButton({
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  void _showFeedbackModal(ProjectEntity project) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Provide Feedback - ${project.title}",
            style: theme.textTheme.titleLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Progress Link:",
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter progress link...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.dividerColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.dividerColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.colorScheme.primary),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Message:",
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Enter feedback message...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.dividerColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.dividerColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.colorScheme.primary),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Cancel",
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: theme.elevatedButtonTheme.style,
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _showFeedback(ProjectEntity project) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Showing feedback for ${project.title}")),
    );
  }

  void _viewDetails(ProjectEntity project) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Viewing details for ${project.title}")),
    );
  }
}
