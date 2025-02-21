import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectsyeti/features/freelancer/domain/entity/freelancer_entity.dart';
import 'package:projectsyeti/features/freelancer/presentation/view_model/freelancer_bloc.dart';

class FreelancerUpdateView extends StatefulWidget {
  final FreelancerEntity freelancer;

  const FreelancerUpdateView({super.key, required this.freelancer});

  @override
  State<FreelancerUpdateView> createState() => _FreelancerUpdateViewState();
}

class _FreelancerUpdateViewState extends State<FreelancerUpdateView> {
  late TextEditingController _nameController;
  late TextEditingController _portfolioController;
  late TextEditingController _availabilityController;
  late TextEditingController _aboutMeController;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.freelancer.freelancerName);
    _portfolioController =
        TextEditingController(text: widget.freelancer.portfolio);
    _availabilityController =
        TextEditingController(text: widget.freelancer.availability);
    _aboutMeController = TextEditingController(text: widget.freelancer.aboutMe);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _portfolioController.dispose();
    _availabilityController.dispose();
    _aboutMeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text("Update Profile"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // PROFILE SECTION
            CircleAvatar(
              radius: 60,
              backgroundImage: widget.freelancer.profileImage.isNotEmpty
                  ? NetworkImage(
                      "http://10.0.2.2:3000/${widget.freelancer.profileImage}")
                  : const AssetImage("assets/images/default_avatar.png")
                      as ImageProvider,
            ),
            const SizedBox(height: 16),

            // Freelancer Name
            _buildTextField("Name", _nameController),
            const SizedBox(height: 10),

            // Portfolio
            _buildTextField("Portfolio", _portfolioController),
            const SizedBox(height: 10),

            // Availability
            _buildTextField("Availability", _availabilityController),
            const SizedBox(height: 10),

            // About Me
            _buildTextField("About Me", _aboutMeController),
            const SizedBox(height: 20),

            // Update Button
            ElevatedButton(
              onPressed: () {
                _onUpdateFreelancer();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text("Update Profile"),
            ),
          ],
        ),
      ),
    );
  }

  // TextField Widget to reuse
  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.white24,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  void _onUpdateFreelancer() {
    final updatedFreelancer = widget.freelancer.copyWith(
      freelancerName: _nameController.text,
      portfolio: _portfolioController.text,
      availability: _availabilityController.text,
      aboutMe: _aboutMeController.text,
    );

    // Trigger update freelancer event here
    context
        .read<FreelancerBloc>()
        .add(UpdateFreelancerEvent(updatedFreelancer));

    // Provide feedback after update (e.g., show a success message)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully!')),
    );
  }
}
