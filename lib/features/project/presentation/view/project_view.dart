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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ProjectBloc, ProjectState>(
          builder: (context, state) {
            if (state is ProjectLoading)
              return const Center(child: CircularProgressIndicator());
            if (state is ProjectLoaded)
              return _buildProjectDetails(state.project);
            if (state is ProjectError)
              return Center(
                  child: Text(state.message,
                      style: const TextStyle(color: Colors.red, fontSize: 18)));
            return const Center(child: Text("No Project Data Available"));
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildBidButton(),
    );
  }

  Widget _buildProjectDetails(ProjectEntity project) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(project.title,
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildCompanyInfo(project),
          const SizedBox(height: 16),
          _buildDetails(project),
          const SizedBox(height: 16),
          _buildCategories(project.category),
          const SizedBox(height: 16),
          _buildRequirements(project.requirements),
        ],
      ),
    );
  }

  Widget _buildCompanyInfo(ProjectEntity project) {
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
        decoration: _boxDecoration(),
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
                  Text(project.companyName,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(
                    project.headquarters ?? "Headquarters not available",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectInfo(ProjectEntity project) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 📌 Categories First
          const Text(
            "Categories:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildCategories(project.category),

          const SizedBox(height: 14),

          // 📌 Posted Date & Duration in a Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoTag(
                  Icons.calendar_today, _formatDate(project.postedDate)),
              _buildInfoTag(Icons.access_time, "${project.duration} months"),
            ],
          ),
        ],
      ),
    );
  }

// 📌 Styled Details Section (Posted Date & Duration)
  Widget _buildDetails(ProjectEntity project) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _boxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDetailCard(Icons.calendar_today, "Posted Date:",
              _formatDate(project.postedDate)),
          _buildDetailCard(
              Icons.access_time, "Duration:", "${project.duration} months"),
        ],
      ),
    );
  }

// 📌 Compact Styled Cards for Posted Date & Duration
  Widget _buildDetailCard(IconData icon, String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100, // Soft background
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF001F3F),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 18, color: Colors.white),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

// 📌 Styled Category Tags in a Row
  Widget _buildCategories(List<String> categories) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((category) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF001F3F), // Matches Buttons & Icons
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

// 📌 Compact Info Tags for Posted Date & Duration
  Widget _buildInfoTag(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF001F3F)),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

// 📌 Styled Requirements Section - Compact & Elegant
  Widget _buildRequirements(String requirements) {
    List<String> requirementList = requirements.split('\n');
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Requirements:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                        style: const TextStyle(fontSize: 16),
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

// 📌 Box Decoration for Sections
  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.15),
          blurRadius: 6,
          spreadRadius: 2,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  Widget _buildBidButton() {
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
            backgroundColor:
                freelancerId.isNotEmpty ? const Color(0xFF001F3F) : Colors.grey,
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
