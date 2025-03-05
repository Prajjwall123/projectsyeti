import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectsyeti/app/shared_prefs/token_shared_prefs.dart';
import 'package:projectsyeti/core/common/snackbar/my_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projectsyeti/features/company/presentation/view/company_view.dart';
import 'package:projectsyeti/features/project/domain/entity/project_entity.dart';
import 'package:projectsyeti/features/bidding/presentation/view/bid_submission_view.dart';
import 'package:projectsyeti/features/project/presentation/view_model/bloc/project_bloc.dart';

class ProjectView extends StatefulWidget {
  final String projectId;

  const ProjectView({super.key, required this.projectId});

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
  late TokenSharedPrefs tokenSharedPrefs;
  String freelancerId = "";

  @override
  void initState() {
    super.initState();
    context.read<ProjectBloc>().add(GetProjectByIdEvent(widget.projectId));
    _initializeTokenSharedPrefs();
  }

  void _initializeTokenSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    tokenSharedPrefs = TokenSharedPrefs(prefs);
    _getUserIdBidSubmissionView();
  }

  void _getUserIdBidSubmissionView() async {
    final userIdResult = await tokenSharedPrefs.getUserId();
    userIdResult.fold(
      (failure) => showMySnackBar(
          context: context,
          message: "Failed to retrieve userId",
          color: Colors.red),
      (userId) =>
          setState(() => freelancerId = userId.isNotEmpty ? userId : ""),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Determine if the theme is dark
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Details'),
        // Ensure the AppBar adapts to the theme (Flutter handles this automatically)
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ProjectBloc, ProjectState>(
          builder: (context, state) {
            if (state is ProjectLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProjectLoaded) {
              return _buildProjectDetails(state.project, isDarkTheme);
            }
            if (state is ProjectError) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(
                    color: isDarkTheme ? Colors.red[300] : Colors.red,
                    fontSize: 18,
                  ),
                ),
              );
            }
            return Center(
              child: Text(
                "No Project Data Available",
                style: TextStyle(
                  color: isDarkTheme ? Colors.white70 : Colors.black54,
                  fontSize: 18,
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildBidButton(isDarkTheme),
    );
  }

  Widget _buildProjectDetails(ProjectEntity project, bool isDarkTheme) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project.title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          _buildCompanyInfo(project, isDarkTheme),
          const SizedBox(height: 16),
          _buildDetails(project, isDarkTheme),
          const SizedBox(height: 16),
          _buildCategories(project.category, isDarkTheme),
          const SizedBox(height: 16),
          _buildRequirements(project.requirements, isDarkTheme),
        ],
      ),
    );
  }

  Widget _buildCompanyInfo(ProjectEntity project, bool isDarkTheme) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CompanyView(companyId: project.companyId),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: _boxDecoration(isDarkTheme),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: project.companyLogo.isNotEmpty
                  ? NetworkImage(
                      "http://192.168.1.70:3000/${project.companyLogo}")
                  : const AssetImage("assets/images/default_company.png")
                      as ImageProvider,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.companyName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkTheme ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    project.headquarters ?? "Headquarters not available",
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkTheme ? Colors.grey[400] : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetails(ProjectEntity project, bool isDarkTheme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _boxDecoration(isDarkTheme),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDetailCard(
            Icons.calendar_today,
            "Posted Date:",
            _formatDate(project.postedDate),
            isDarkTheme,
          ),
          _buildDetailCard(
            Icons.access_time,
            "Duration:",
            "${project.duration} months",
            isDarkTheme,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(
      IconData icon, String label, String value, bool isDarkTheme) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDarkTheme ? Colors.grey[800] : Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color:
                    const Color(0xFF001F3F), // Keep this color for consistency
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 18, color: Colors.white),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDarkTheme ? Colors.white70 : Colors.black87,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkTheme ? Colors.grey[400] : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories(List<String> categories, bool isDarkTheme) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((category) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF001F3F),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            category,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRequirements(String requirements, bool isDarkTheme) {
    List<String> requirementList = requirements.split('\n');
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _boxDecoration(isDarkTheme),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Requirements:",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(requirementList.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${index + 1}.",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        requirementList[index],
                        style: TextStyle(
                          fontSize: 16,
                          color: isDarkTheme ? Colors.white70 : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration(bool isDarkTheme) {
    return BoxDecoration(
      color: isDarkTheme ? Colors.grey[900] : Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: isDarkTheme
              ? Colors.black.withOpacity(0.3)
              : Colors.grey.withOpacity(0.15),
          blurRadius: 6,
          spreadRadius: 2,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  Widget _buildBidButton(bool isDarkTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: freelancerId.isNotEmpty
              ? () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BidSubmissionView(
                        projectId: widget.projectId,
                        freelancerId: freelancerId,
                      ),
                    ),
                  )
              : null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: freelancerId.isNotEmpty
                ? const Color(0xFF001F3F)
                : (isDarkTheme ? Colors.grey[700] : Colors.grey),
          ),
          child: const Text(
            "Bid for Project",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
