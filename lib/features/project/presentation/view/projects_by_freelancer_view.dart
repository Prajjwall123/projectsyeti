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
    final theme = Theme.of(context);

    return BlocProvider<ProjectBloc>(
      create: (context) => getIt<ProjectBloc>(),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Your Projects'),
        ),
        body: SafeArea(
          child: BlocConsumer<ProjectBloc, ProjectState>(
            listener: (context, state) {
              if (state is ProjectUpdated) {
                // Update the local projects list with the updated project
                setState(() {
                  projects = projects.map((project) {
                    if (project.projectId == state.updatedProject.projectId) {
                      return state.updatedProject;
                    }
                    return project;
                  }).toList();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Project updated successfully')),
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
                    _buildStatusDropdown(context, project),
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

  Widget _buildStatusDropdown(BuildContext context, ProjectEntity project) {
    final theme = Theme.of(context);
    final projectBloc = BlocProvider.of<ProjectBloc>(
        context); // Capture the ProjectBloc instance
    final statuses = [
      "awarded",
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
            _showFeedbackModal(context, projectBloc, project, newStatus);
          } else {
            // Update project status without feedback
            if (project.projectId != null) {
              final updatedProject = project.copyWith(
                status: newStatus,
              );
              projectBloc.add(UpdateProjectByIdEvent(
                project.projectId!,
                updatedProject,
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Project ID is missing")),
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

  void _showFeedbackModal(BuildContext context, ProjectBloc projectBloc,
      ProjectEntity project, String newStatus) {
    final theme = Theme.of(context);
    final progressLinkController = TextEditingController();
    final messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
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
                controller: progressLinkController,
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
                controller: messageController,
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
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                "Cancel",
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (project.projectId != null) {
                  // Update project with feedback details
                  final updatedProject = project.copyWith(
                    status: newStatus,
                    feedbackRequestedMessage: messageController.text,
                    link: progressLinkController.text,
                  );
                  projectBloc.add(UpdateProjectByIdEvent(
                    project.projectId!,
                    updatedProject,
                  ));
                  Navigator.of(dialogContext).pop();
                } else {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    const SnackBar(content: Text("Project ID is missing")),
                  );
                }
              },
              style: theme.elevatedButtonTheme.style,
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _showFeedback(ProjectEntity project) {
    if (project.feedbackRequestedMessage != null &&
        project.feedbackRequestedMessage!.isNotEmpty) {
      showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(
              "Feedback for ${project.title}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Progress Link: ${project.link ?? 'Not provided'}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  "Message: ${project.feedbackRequestedMessage}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text(
                  "Close",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No feedback available for this project")),
      );
    }
  }

  void _viewDetails(ProjectEntity project) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Viewing details for ${project.title}")),
    );
  }
}
