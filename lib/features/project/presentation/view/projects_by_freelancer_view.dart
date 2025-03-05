import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectsyeti/core/common/snackbar/my_snackbar.dart';
import 'package:projectsyeti/features/project/domain/entity/project_entity.dart';
import 'package:projectsyeti/features/project/presentation/view/provide_feedback_view.dart';
import 'package:projectsyeti/features/project/presentation/view_model/bloc/project_bloc.dart';

class ProjectsByFreelancerView extends StatefulWidget {
  final String? freelancerId;

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
    final projectBloc = context.read<ProjectBloc>();
    if (!projectBloc.isClosed && widget.freelancerId != null) {
      projectBloc.add(GetProjectsByFreelancerIdEvent(widget.freelancerId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Your Projects'),
      ),
      body: SafeArea(
        child: BlocConsumer<ProjectBloc, ProjectState>(
          listener: (context, state) {
            if (state is ProjectUpdated) {
              setState(() {
                projects = projects.map((project) {
                  if (project.projectId == state.updatedProject.projectId) {
                    return state.updatedProject;
                  }
                  return project;
                }).toList();
              });
              showMySnackBar(
                context: context,
                message: "Project Status updated successfully",
                color: Colors.green,
              );
            } else if (state is ProjectError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is ProjectLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProjectsLoaded) {
              projects = state.projects;
              if (projects.isEmpty) {
                return Center(
                  child: Text(
                    "No Projects Available",
                    style: TextStyle(
                      color: isDarkTheme ? Colors.white70 : Colors.black54,
                      fontSize: 18,
                    ),
                  ),
                );
              }
              return _buildProjectList();
            } else if (state is ProjectError) {
              return Center(
                child: Text(
                  "Error: ${state.message}",
                  style: TextStyle(
                    color:
                        isDarkTheme ? Colors.red[300] : theme.colorScheme.error,
                    fontSize: 18,
                  ),
                ),
              );
            }
            return Center(
              child: Text(
                "No Projects Available",
                style: TextStyle(
                  color: isDarkTheme ? Colors.white70 : Colors.black54,
                  fontSize: 18,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProjectList() {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
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
          color: isDarkTheme ? Colors.grey[900] : Colors.white,
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
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
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
                  project.companyName ?? 'Unknown',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
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

    // Normalize the project status to match the statuses list
    String? normalizedStatus = project.status;
    // Find a matching status in the list (case-insensitive)
    normalizedStatus = statuses.firstWhere(
      (status) => status.toLowerCase() == normalizedStatus!.toLowerCase(),
      orElse: () => "To Do", // Default to "To Do" if no match is found
    );

    return DropdownButton<String>(
      value: normalizedStatus,
      isDense: true,
      items: statuses.map((status) {
        return DropdownMenuItem<String>(
          value: status,
          child: Text(
            status,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.brightness == Brightness.dark
                  ? Colors.white70
                  : Colors.black87,
            ),
            softWrap: true,
          ),
        );
      }).toList(),
      onChanged: (newStatus) {
        if (newStatus != null && newStatus != project.status) {
          if (newStatus == "Feedback Requested") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProvideFeedbackView(
                  project: project,
                  newStatus: newStatus,
                ),
              ),
            );
          } else {
            // Update project status without feedback
            if (project.projectId != null) {
              final updatedProject = project.copyWith(
                status: newStatus,
              );
              final projectBloc = context.read<ProjectBloc>();
              if (!projectBloc.isClosed) {
                projectBloc.add(UpdateProjectByIdEvent(
                  project.projectId!,
                  updatedProject,
                ));
              }
            } else {
              showMySnackBar(
                context: context,
                message: "Project ID is missing",
                color: Colors.red,
              );
            }
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

  void _showFeedback(ProjectEntity project) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    if (project.feedbackRespondMessage != null &&
        project.feedbackRespondMessage!.isNotEmpty) {
      showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            backgroundColor: isDarkTheme ? Colors.grey[900] : Colors.white,
            title: Text(
              "Feedback for ${project.title}",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Progress Link: ${project.link ?? 'Not provided'}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDarkTheme ? Colors.white70 : Colors.black87,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Message: ${project.feedbackRespondMessage}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDarkTheme ? Colors.white70 : Colors.black87,
                      ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text(
                  "Close",
                  style: TextStyle(
                    color: isDarkTheme
                        ? Colors.white70
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        showMySnackBar(
          context: context,
          message: "No feedback available for this project",
          color: Colors.red,
        ),
      );
    }
  }

  void _viewDetails(ProjectEntity project) {
    showMySnackBar(
      context: context,
      message: "Viewing details for ${project.title}",
      color: Colors.green,
    );
  }
}
