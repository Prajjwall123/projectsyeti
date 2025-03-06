import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectsyeti/core/app_theme/theme_provider.dart';
import 'package:projectsyeti/core/common/snackbar/my_snackbar.dart';
import 'package:projectsyeti/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:projectsyeti/features/certification/domain/entity/certification_entity.dart';
import 'package:projectsyeti/features/experience/domain/entity/experience_entity.dart';
import 'package:projectsyeti/features/freelancer/domain/entity/freelancer_entity.dart';
import 'package:projectsyeti/features/freelancer/presentation/view/certification_form.dart';
import 'package:projectsyeti/features/freelancer/presentation/view/experience_form.dart';
import 'package:projectsyeti/features/freelancer/presentation/view_model/freelancer_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FreelancerUpdateView extends StatefulWidget {
  final FreelancerEntity freelancer;

  const FreelancerUpdateView({super.key, required this.freelancer});

  @override
  _FreelancerUpdateViewState createState() => _FreelancerUpdateViewState();
}

class _FreelancerUpdateViewState extends State<FreelancerUpdateView> {
  bool _isUploading = false;

  late TextEditingController _nameController;
  late TextEditingController _portfolioController;
  late TextEditingController _availabilityController;
  late TextEditingController _aboutMeController;
  late TextEditingController _professionController;
  late TextEditingController _locationController;
  late TextEditingController _workAtController;
  late TextEditingController _languagesController;
  late TextEditingController _experienceYearsController;
  late TextEditingController _profileImageController;

  late List<TextEditingController> _certificationsControllers;
  late List<TextEditingController> _organizationControllers;

  late List<TextEditingController> _experienceControllers;
  late List<TextEditingController> _companyControllers;
  late List<TextEditingController> _fromControllers;
  late List<TextEditingController> _toControllers;
  late List<TextEditingController> _descriptionControllers;

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    _nameController =
        TextEditingController(text: widget.freelancer.freelancerName);
    _portfolioController =
        TextEditingController(text: widget.freelancer.portfolio ?? '');
    _availabilityController =
        TextEditingController(text: widget.freelancer.availability ?? '');
    _aboutMeController =
        TextEditingController(text: widget.freelancer.aboutMe ?? '');
    _professionController =
        TextEditingController(text: widget.freelancer.profession ?? '');
    _locationController =
        TextEditingController(text: widget.freelancer.location ?? '');
    _workAtController =
        TextEditingController(text: widget.freelancer.workAt ?? '');
    _languagesController = TextEditingController(
        text: widget.freelancer.languages?.join(', ') ?? '');
    _experienceYearsController = TextEditingController(
        text: widget.freelancer.experienceYears.toString() ?? '0');
    _profileImageController =
        TextEditingController(text: widget.freelancer.profileImage ?? '');

    _certificationsControllers = List.generate(
      widget.freelancer.certifications?.length ?? 0,
      (index) => TextEditingController(
          text: widget.freelancer.certifications?[index].name),
    );
    _organizationControllers = List.generate(
      widget.freelancer.certifications?.length ?? 0,
      (index) => TextEditingController(
          text: widget.freelancer.certifications?[index].organization),
    );

    _experienceControllers = List.generate(
      widget.freelancer.experience?.length ?? 0,
      (index) => TextEditingController(
          text: widget.freelancer.experience?[index].title),
    );
    _companyControllers = List.generate(
      widget.freelancer.experience?.length ?? 0,
      (index) => TextEditingController(
          text: widget.freelancer.experience?[index].company),
    );
    _fromControllers = List.generate(
      widget.freelancer.experience?.length ?? 0,
      (index) => TextEditingController(
          text: widget.freelancer.experience?[index].from.toString()),
    );
    _toControllers = List.generate(
      widget.freelancer.experience?.length ?? 0,
      (index) => TextEditingController(
          text: widget.freelancer.experience?[index].to.toString()),
    );
    _descriptionControllers = List.generate(
      widget.freelancer.experience?.length ?? 0,
      (index) => TextEditingController(
          text: widget.freelancer.experience?[index].description),
    );
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedImage != null) {
      setState(() {
        _isUploading = true;
      });

      final uploadImageUsecase = context.read<UploadImageUsecase>();
      final result = await uploadImageUsecase
          .call(UploadImageParams(file: _selectedImage!));

      setState(() {
        _isUploading = false;
      });

      result.fold(
        (failure) {
          print('Error uploading image: $failure');
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Image upload failed: $failure')));
        },
        (imageUrl) {
          _profileImageController.text = imageUrl;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Image uploaded successfully')));
        },
      );
    }
  }

  void _saveFreelancerDetails() async {
    await _uploadImage().then((_) {
      final updatedFreelancer = FreelancerEntity(
        id: widget.freelancer.id,
        freelancerName: _nameController.text,
        portfolio: _portfolioController.text,
        availability: _availabilityController.text,
        aboutMe: _aboutMeController.text,
        profession: _professionController.text,
        location: _locationController.text,
        workAt: _workAtController.text,
        languages: _languagesController.text
            .split(',')
            .map((lang) => lang.trim())
            .toList(),
        experienceYears: int.tryParse(_experienceYearsController.text) ?? 0,
        profileImage: _profileImageController.text,
        skills: widget.freelancer.skills,
        projectsCompleted: widget.freelancer.projectsCompleted,
        userId: widget.freelancer.userId,
        certifications:
            List.generate(_certificationsControllers.length, (index) {
          return CertificationEntity(
            name: _certificationsControllers[index].text,
            organization: _organizationControllers[index].text,
          );
        }).toList(),
        experience: List.generate(_experienceControllers.length, (index) {
          return ExperienceEntity(
            title: _experienceControllers[index].text,
            company: _companyControllers[index].text,
            from: int.tryParse(_fromControllers[index].text) ?? 0,
            to: int.tryParse(_toControllers[index].text) ?? 0,
            description: _descriptionControllers[index].text,
          );
        }).toList(),
      );
      context
          .read<FreelancerBloc>()
          .add(UpdateFreelancerEvent(updatedFreelancer));
      showMySnackBar(
        context: context,
        message: "Profile updated successfully",
        color: Colors.green,
      );
      Navigator.pop(context, widget.freelancer.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDarkTheme = themeProvider.themeMode == ThemeMode.dark;

    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Update Your Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image Section
              _buildSectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Profile Image',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isDarkTheme
                                    ? Colors.grey[700]!
                                    : Colors.grey[300]!,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: isDarkTheme
                                      ? Colors.black26
                                      : Colors.grey.withOpacity(0.2),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey[200],
                              backgroundImage: _selectedImage != null
                                  ? FileImage(_selectedImage!)
                                  : widget.freelancer.profileImage.isNotEmpty
                                      ? NetworkImage(
                                          'http://192.168.1.70:3000/${widget.freelancer.profileImage}')
                                      : null,
                              child: _selectedImage == null &&
                                      widget.freelancer.profileImage.isEmpty
                                  ? const Icon(Icons.person,
                                      size: 60, color: Colors.grey)
                                  : null,
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (_isUploading) ...[
                      const CircularProgressIndicator(),
                      const SizedBox(height: 8),
                      const Text(
                        'Uploading image...',
                        style: TextStyle(
                            fontSize: 14, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ],
                ),
                isDarkTheme: isDarkTheme,
              ),

              const SizedBox(height: 24),

              // Personal Details Section
              _buildSectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Personal Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Name',
                      controller: _nameController,
                      theme: theme,
                      isDarkTheme: isDarkTheme,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Portfolio',
                      controller: _portfolioController,
                      theme: theme,
                      isDarkTheme: isDarkTheme,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Availability',
                      controller: _availabilityController,
                      theme: theme,
                      isDarkTheme: isDarkTheme,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'About Me',
                      controller: _aboutMeController,
                      theme: theme,
                      isDarkTheme: isDarkTheme,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Profession',
                      controller: _professionController,
                      theme: theme,
                      isDarkTheme: isDarkTheme,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Address',
                      controller: _locationController,
                      theme: theme,
                      isDarkTheme: isDarkTheme,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Work At',
                      controller: _workAtController,
                      theme: theme,
                      isDarkTheme: isDarkTheme,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Languages',
                      controller: _languagesController,
                      theme: theme,
                      isDarkTheme: isDarkTheme,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Experience Years',
                      controller: _experienceYearsController,
                      theme: theme,
                      isDarkTheme: isDarkTheme,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                isDarkTheme: isDarkTheme,
              ),

              const SizedBox(height: 24),

              // Certifications Section
              _buildSectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Certifications',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CertificationForm(
                      certificationsControllers: _certificationsControllers,
                      organizationControllers: _organizationControllers,
                      addCertification: () {
                        setState(() {
                          _certificationsControllers
                              .add(TextEditingController());
                          _organizationControllers.add(TextEditingController());
                        });
                      },
                      removeCertification: (index) {
                        setState(() {
                          _certificationsControllers.removeAt(index);
                          _organizationControllers.removeAt(index);
                        });
                      },
                    ),
                  ],
                ),
                isDarkTheme: isDarkTheme,
              ),

              const SizedBox(height: 24),

              // Experience Section
              _buildSectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Experience',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ExperienceForm(
                      experienceControllers: _experienceControllers,
                      companyControllers: _companyControllers,
                      fromControllers: _fromControllers,
                      toControllers: _toControllers,
                      descriptionControllers: _descriptionControllers,
                      addExperience: () {
                        setState(() {
                          _experienceControllers.add(TextEditingController());
                          _companyControllers.add(TextEditingController());
                          _fromControllers.add(TextEditingController());
                          _toControllers.add(TextEditingController());
                          _descriptionControllers.add(TextEditingController());
                        });
                      },
                      removeExperience: (index) {
                        setState(() {
                          _experienceControllers.removeAt(index);
                          _companyControllers.removeAt(index);
                          _fromControllers.removeAt(index);
                          _toControllers.removeAt(index);
                          _descriptionControllers.removeAt(index);
                        });
                      },
                    ),
                  ],
                ),
                isDarkTheme: isDarkTheme,
              ),

              // Add extra padding at the bottom to ensure content is not obscured by the floating button
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 1),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _saveFreelancerDetails,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
            ),
            child: const Text(
              'Save Changes',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // Helper method to build a styled section card
  Widget _buildSectionCard({required Widget child, required bool isDarkTheme}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkTheme ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDarkTheme ? Colors.black26 : Colors.grey.withOpacity(0.15),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  // Helper method to build a styled TextField
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required ThemeData theme,
    required bool isDarkTheme,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: isDarkTheme ? Colors.grey[800] : Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isDarkTheme ? Colors.grey[700]! : Colors.grey[300]!,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
          style: TextStyle(
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _portfolioController.dispose();
    _availabilityController.dispose();
    _aboutMeController.dispose();
    _professionController.dispose();
    _locationController.dispose();
    _workAtController.dispose();
    _languagesController.dispose();
    _experienceYearsController.dispose();
    _profileImageController.dispose();
    for (var controller in _certificationsControllers) {
      controller.dispose();
    }
    for (var controller in _organizationControllers) {
      controller.dispose();
    }
    for (var controller in _experienceControllers) {
      controller.dispose();
    }
    for (var controller in _companyControllers) {
      controller.dispose();
    }
    for (var controller in _fromControllers) {
      controller.dispose();
    }
    for (var controller in _toControllers) {
      controller.dispose();
    }
    for (var controller in _descriptionControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
