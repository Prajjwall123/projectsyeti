import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectsyeti/core/app_theme/theme_provider.dart';
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
      text: widget.freelancer.experienceYears.toString() ?? '0',
    );
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

  void _saveFreelancerDetails() {
    _uploadImage().then((_) {
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
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')));
      Navigator.pop(context); // Navigate back after saving
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDarkTheme = themeProvider.themeMode == ThemeMode.dark;

    // Get the bottom padding for the safe area and BottomNavigationBar
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    const double navBarHeight = 56.0;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Update Your Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomPadding + navBarHeight + 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Profile Image
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _selectedImage != null
                            ? FileImage(_selectedImage!)
                            : widget.freelancer.profileImage.isNotEmpty
                                ? NetworkImage(
                                    'http://192.168.1.70:3000/${widget.freelancer.profileImage}')
                                : null,
                        child: _selectedImage == null &&
                                (widget.freelancer.profileImage.isEmpty)
                            ? const Icon(Icons.person, size: 50)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                if (_isUploading) ...[
                  const Center(child: CircularProgressIndicator()),
                  const SizedBox(height: 8),
                  const Center(child: Text('Uploading image...')),
                ],
                const SizedBox(height: 16),

                // Name
                Text(
                  'Name',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.dividerColor),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.dividerColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.colorScheme.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Portfolio
                Text(
                  'Portfolio',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _portfolioController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.dividerColor),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.dividerColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.colorScheme.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Availability
                Text(
                  'Availability',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _availabilityController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.dividerColor),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.dividerColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.colorScheme.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // About Me
                Text(
                  'About Me',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _aboutMeController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.dividerColor),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.dividerColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.colorScheme.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Profession
                Text(
                  'Profession',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _professionController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.dividerColor),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.dividerColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.colorScheme.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Location
                Text(
                  'Location',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.dividerColor),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.dividerColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.colorScheme.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Work At
                Text(
                  'Work At',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _workAtController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.dividerColor),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.dividerColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.colorScheme.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Languages
                Text(
                  'Languages',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _languagesController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.dividerColor),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.dividerColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.colorScheme.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Experience Years
                Text(
                  'Experience Years',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _experienceYearsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.dividerColor),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.dividerColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.colorScheme.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Certifications Section
                Text(
                  'Certifications:',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                CertificationForm(
                  certificationsControllers: _certificationsControllers,
                  organizationControllers: _organizationControllers,
                  addCertification: () {
                    setState(() {
                      _certificationsControllers.add(TextEditingController());
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
                const SizedBox(height: 24),

                // Experience Section
                Text(
                  'Experience:',
                  style: theme.textTheme.titleLarge,
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
                const SizedBox(height: 24),

                // Save Button
                Center(
                  child: ElevatedButton(
                    onPressed: _saveFreelancerDetails,
                    style: theme.elevatedButtonTheme.style?.copyWith(
                      minimumSize: WidgetStateProperty.all(
                        const Size(200, 48),
                      ),
                    ),
                    child: const Text('Save Changes'),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
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
