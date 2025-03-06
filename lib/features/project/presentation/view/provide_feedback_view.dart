import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectsyeti/core/common/snackbar/my_snackbar.dart';
import 'package:projectsyeti/features/project/domain/entity/project_entity.dart';
import 'package:projectsyeti/features/project/presentation/view/projects_by_freelancer_view.dart';
import 'package:projectsyeti/features/project/presentation/view_model/bloc/project_bloc.dart';

class ProvideFeedbackView extends StatefulWidget {
  final ProjectEntity project;
  final String newStatus;

  const ProvideFeedbackView({
    super.key,
    required this.project,
    required this.newStatus,
  });

  @override
  _ProvideFeedbackViewState createState() => _ProvideFeedbackViewState();
}

class _ProvideFeedbackViewState extends State<ProvideFeedbackView> {
  final progressLinkController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void dispose() {
    progressLinkController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Request Feedback",
        ),
        elevation: 2,
        backgroundColor: theme.appBarTheme.backgroundColor ??
            (isDarkTheme ? Colors.grey[900] : Colors.white),
      ),
      body: BlocConsumer<ProjectBloc, ProjectState>(
        listener: (context, state) {
          if (state is ProjectUpdated) {
            showMySnackBar(
              context: context,
              message: "Project status updated successfully",
              color: Colors.green,
            );
            if (mounted) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ProjectsByFreelancerView(
                    freelancerId: state.updatedProject.awardedTo!,
                  ),
                ),
              );
            }
          } else if (state is ProjectError) {
            showMySnackBar(
              context: context,
              message: state.message,
              color: Colors.red,
            );
          }
        },
        builder: (context, state) {
          bool isSubmitting = state is ProjectLoading;
          return SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.only(bottom: 24.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Project",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: isDarkTheme
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.project.title,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color:
                                  isDarkTheme ? Colors.white : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Company",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: isDarkTheme
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.project.companyName ?? 'Unknown',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color:
                                  isDarkTheme ? Colors.white70 : Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Status",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: isDarkTheme
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.project.status,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: widget.project.status == "In Progress"
                                  ? Colors.orange
                                  : widget.project.status ==
                                          "Feedback Requested"
                                      ? Colors.blue
                                      : widget.project.status == "Done"
                                          ? Colors.green
                                          : Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "Progress Link",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDarkTheme ? Colors.grey[300] : Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: progressLinkController,
                    decoration: InputDecoration(
                      hintText: "Enter progress link...",
                      hintStyle: TextStyle(
                        color:
                            isDarkTheme ? Colors.grey[500] : Colors.grey[400],
                      ),
                      labelText: "Progress Link",
                      labelStyle: TextStyle(
                        color:
                            isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: theme.dividerColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: isDarkTheme
                              ? Colors.grey[700]!
                              : Colors.grey[300]!,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: theme.colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor:
                          isDarkTheme ? Colors.grey[800] : Colors.grey[50],
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 16.0,
                      ),
                    ),
                    keyboardType: TextInputType.url,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Message",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDarkTheme ? Colors.grey[300] : Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: messageController,
                    maxLines: 5,
                    maxLength: 500,
                    decoration: InputDecoration(
                      hintText: "Enter your feedback message...",
                      hintStyle: TextStyle(
                        color:
                            isDarkTheme ? Colors.grey[500] : Colors.grey[400],
                      ),
                      labelText: "Feedback Message",
                      labelStyle: TextStyle(
                        color:
                            isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: theme.dividerColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: isDarkTheme
                              ? Colors.grey[700]!
                              : Colors.grey[300]!,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: theme.colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor:
                          isDarkTheme ? Colors.grey[800] : Colors.grey[50],
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 16.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: isSubmitting
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              theme.colorScheme.primary,
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              if (widget.project.projectId != null) {
                                final updatedProject = widget.project.copyWith(
                                  status: widget.newStatus,
                                  feedbackRequestedMessage:
                                      messageController.text,
                                  link: progressLinkController.text,
                                );

                                context
                                    .read<ProjectBloc>()
                                    .add(UpdateProjectByIdEvent(
                                      widget.project.projectId!,
                                      updatedProject,
                                    ));
                              } else {
                                showMySnackBar(
                                  context: context,
                                  message: "Project ID is missing",
                                  color: Colors.red,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 3,
                              shadowColor:
                                  theme.colorScheme.primary.withOpacity(0.3),
                              minimumSize: const Size(200, 56),
                            ),
                            child: Text(
                              "Submit",
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
