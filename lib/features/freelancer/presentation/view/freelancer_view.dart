import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectsyeti/features/freelancer/domain/entity/freelancer_entity.dart';
import 'package:projectsyeti/features/freelancer/presentation/view_model/freelancer_bloc.dart';
import 'package:projectsyeti/features/freelancer/presentation/view/freelancer_update_view.dart';

class FreelancerView extends StatefulWidget {
  final String freelancerId;

  const FreelancerView({super.key, required this.freelancerId});

  @override
  State<FreelancerView> createState() => _FreelancerViewState();
}

class _FreelancerViewState extends State<FreelancerView> {
  @override
  void initState() {
    super.initState();
    context
        .read<FreelancerBloc>()
        .add(GetFreelancerByIdEvent(widget.freelancerId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text("Freelancer Profile"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<FreelancerBloc, FreelancerState>(
          builder: (context, state) {
            if (state is FreelancerLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FreelancerLoaded) {
              return _buildProfileContent(state.freelancer);
            } else if (state is FreelancerError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red, fontSize: 18),
                ),
              );
            }
            return const Center(child: Text("No Freelancer Data Available"));
          },
        ),
      ),
    );
  }

  Widget _buildProfileContent(FreelancerEntity freelancer) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // PROFILE SECTION
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: freelancer.profileImage.isNotEmpty
                      ? NetworkImage(
                          "http://10.0.2.2:3000/${freelancer.profileImage}")
                      : const AssetImage("assets/images/default_avatar.png")
                          as ImageProvider,
                ),
                const SizedBox(height: 12),
                Text(
                  freelancer.freelancerName,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  "Profession: ${freelancer.profession ?? 'Not specified'}",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Text(
                  "Location: ${freelancer.location}",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Text(
                  "Experience: ${freelancer.experienceYears} years",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the update profile screen
                    _onUpdateFreelancer(freelancer);
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text("Update Profile"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          _buildSectionHeader("About Me"),
          _buildCard([
            _buildDetailRow("I work at", freelancer.workAt ?? "Not specified"),
            _buildDetailRow(
                "Languages",
                (freelancer.languages?.isEmpty ?? true)
                    ? "Not specified"
                    : freelancer.languages!.join(", ")),
            _buildDetailRow(
                "Joined Date",
                freelancer.createdAt?.toLocal().toString().split(" ")[0] ??
                    "Not specified"),
            _buildDetailRow(
                "Availability", freelancer.availability ?? "Not specified"),
          ]),
          const SizedBox(height: 20),

          // EXPERIENCE SECTION
          _buildSectionHeader("Experience"),
          ...(freelancer.experience?.isEmpty ?? true
              ? [_buildDetailRow("Experience", "Not specified")]
              : freelancer.experience!
                  .map((exp) => _buildExperienceCard(exp))
                  .toList()),

          const SizedBox(height: 20),
          // SKILLS SECTION
          _buildSectionHeader("Skills"),
          ...((freelancer.skills.isEmpty ?? true)
              ? [_buildDetailRow("Skills", "Not specified")]
              : [
                  _buildSkillChips(
                      freelancer.skills.map((skill) => skill.name).toList())
                ]), // Using _buildSkillChips
          const SizedBox(height: 20),

          // CERTIFICATIONS SECTION
          _buildSectionHeader("Certifications"),
          ...(freelancer.certifications?.isEmpty ?? true
              ? [_buildDetailRow("Certifications", "Not specified")]
              : freelancer.certifications!
                  .map((cert) => _buildCertificationRow(cert))
                  .toList()),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Skills Chips
  Widget _buildSkillChips(List<String> skills) {
    return Wrap(
      spacing: 8,
      children: skills.map((skill) {
        return Chip(
          label: Text(skill, style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        );
      }).toList(),
    );
  }

  // Section Header
  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  // Detail Cards
  Widget _buildCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
          Text(value,
              style: const TextStyle(fontSize: 16, color: Colors.white)),
        ],
      ),
    );
  }

  // Experience Card
  Widget _buildExperienceCard(dynamic exp) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exp.title,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(exp.description,
              style: const TextStyle(fontSize: 14, color: Colors.grey)),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "at ${exp.company} | ${exp.from} - ${exp.to}",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  // Certifications
  Widget _buildCertificationRow(dynamic cert) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, size: 18, color: Colors.green),
          const SizedBox(width: 8),
          Text(
            "${cert.name} - ${cert.organization}",
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }

  void _onUpdateFreelancer(FreelancerEntity freelancer) {
    // Navigate to the FreelancerUpdateView
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FreelancerUpdateView(
          freelancer: freelancer, // Pass the freelancer data
        ),
      ),
    );
  }
}
