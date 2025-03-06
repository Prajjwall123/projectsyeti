import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectsyeti/core/app_theme/theme_provider.dart';
import 'package:projectsyeti/features/freelancer/domain/entity/freelancer_entity.dart';
import 'package:projectsyeti/features/freelancer/presentation/view_model/freelancer_bloc.dart';
import 'package:projectsyeti/features/freelancer/presentation/view/freelancer_update_view.dart';
import 'package:provider/provider.dart';

class FreelancerView extends StatefulWidget {
  final String freelancerId;

  const FreelancerView({super.key, required this.freelancerId});

  @override
  State<FreelancerView> createState() => _FreelancerViewState();
}

class _FreelancerViewState extends State<FreelancerView>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _profileFade;
  late Animation<double> _aboutMeFade;
  late Animation<double> _experienceFade;
  late Animation<double> _skillsFade;
  late Animation<double> _certificationsFade;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..forward();

    _profileFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.0, 0.2, curve: Curves.easeIn),
      ),
    );
    _aboutMeFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.2, 0.4, curve: Curves.easeIn),
      ),
    );
    _experienceFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.4, 0.6, curve: Curves.easeIn),
      ),
    );
    _skillsFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.6, 0.8, curve: Curves.easeIn),
      ),
    );
    _certificationsFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.8, 1.0, curve: Curves.easeIn),
      ),
    );

    context
        .read<FreelancerBloc>()
        .add(GetFreelancerByIdEvent(widget.freelancerId));
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDarkTheme = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor: isDarkTheme ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        title: const Text("Freelancer Profile"),
        centerTitle: true,
        elevation: 1,
        titleTextStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<FreelancerBloc, FreelancerState>(
          builder: (context, state) {
            if (state is FreelancerLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FreelancerLoaded) {
              return _buildProfileContent(state.freelancer, isDarkTheme);
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

  Widget _buildProfileContent(FreelancerEntity freelancer, bool isDarkTheme) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    const double navBarHeight = 56.0;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding + navBarHeight + 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeTransition(
              opacity: _profileFade,
              child: Center(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkTheme ? Colors.black87 : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: freelancer.profileImage.isNotEmpty
                            ? NetworkImage(
                                "http://192.168.1.70:3000/${freelancer.profileImage}")
                            : const AssetImage(
                                    "assets/images/default_avatar.png")
                                as ImageProvider,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        freelancer.freelancerName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDarkTheme ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Profession: ${freelancer.profession ?? 'Not specified'}",
                        style: TextStyle(
                          fontSize: 16,
                          color: isDarkTheme ? Colors.grey : Colors.grey[600],
                        ),
                      ),
                      Text(
                        "Location: ${freelancer.location}",
                        style: TextStyle(
                          fontSize: 16,
                          color: isDarkTheme ? Colors.grey : Colors.grey[600],
                        ),
                      ),
                      Text(
                        "Experience: ${freelancer.experienceYears} years",
                        style: TextStyle(
                          fontSize: 16,
                          color: isDarkTheme ? Colors.grey : Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          _onUpdateFreelancer(freelancer);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Update Profile",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _aboutMeFade,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader("About Me", isDarkTheme),
                  _buildCard([
                    _buildDetailRow("I work at",
                        freelancer.workAt ?? "Not specified", isDarkTheme),
                    _buildDetailRow(
                      "Languages",
                      (freelancer.languages?.isEmpty ?? true)
                          ? "Not specified"
                          : freelancer.languages!.join(", "),
                      isDarkTheme,
                    ),
                    _buildDetailRow(
                      "Availability",
                      freelancer.availability ?? "Not specified",
                      isDarkTheme,
                    ),
                    _buildDetailRow("Bio",
                        freelancer.aboutMe ?? "Not specified", isDarkTheme),
                  ], isDarkTheme),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _experienceFade,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader("Experience", isDarkTheme),
                  ...(freelancer.experience?.isEmpty ?? true
                      ? [
                          _buildDetailRow(
                              "Experience", "Not specified", isDarkTheme)
                        ]
                      : freelancer.experience!
                          .map((exp) => _buildExperienceCard(exp, isDarkTheme))
                          .toList()),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _skillsFade,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader("Skills", isDarkTheme),
                  ...((freelancer.skills.isEmpty ?? true)
                      ? [
                          _buildDetailRow(
                              "Skills", "Not specified", isDarkTheme)
                        ]
                      : [
                          _buildSkillChips(
                            freelancer.skills
                                .map((skill) => skill.name)
                                .toList(),
                            isDarkTheme,
                          )
                        ]),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _certificationsFade,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader("Certifications", isDarkTheme),
                  ...(freelancer.certifications?.isEmpty ?? true
                      ? [
                          _buildDetailRow(
                              "Certifications", "Not specified", isDarkTheme)
                        ]
                      : freelancer.certifications!
                          .map((cert) =>
                              _buildCertificationRow(cert, isDarkTheme))
                          .toList()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillChips(List<String> skills, bool isDarkTheme) {
    return Wrap(
      spacing: 8,
      children: skills.map((skill) {
        return Chip(
          label: Text(
            skill,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Colors.white),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSectionHeader(String title, bool isDarkTheme) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children, bool isDarkTheme) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: isDarkTheme ? Colors.black87 : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDetailRow(String label, String value, bool isDarkTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDarkTheme ? Colors.grey : Colors.grey[600],
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(dynamic exp, bool isDarkTheme) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: isDarkTheme ? Colors.black87 : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exp.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            exp.description,
            style: TextStyle(
              fontSize: 14,
              color: isDarkTheme ? Colors.grey : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "at ${exp.company} | ${exp.from} - ${exp.to}",
              style: TextStyle(
                fontSize: 14,
                color: isDarkTheme ? Colors.grey : Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationRow(dynamic cert, bool isDarkTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, size: 18, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "${cert.name} - ${cert.organization}",
              style: TextStyle(
                fontSize: 16,
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _onUpdateFreelancer(FreelancerEntity freelancer) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FreelancerUpdateView(
          freelancer: freelancer,
        ),
      ),
    );
  }
}
