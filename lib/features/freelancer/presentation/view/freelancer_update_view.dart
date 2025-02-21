import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectsyeti/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:projectsyeti/features/certification/domain/entity/certification_entity.dart';
import 'package:projectsyeti/features/experience/domain/entity/experience_entity.dart';
import 'package:projectsyeti/features/freelancer/domain/entity/freelancer_entity.dart';
import 'package:projectsyeti/features/freelancer/presentation/view/certification_form.dart';
import 'package:projectsyeti/features/freelancer/presentation/view/experience_form.dart';
import 'package:projectsyeti/features/freelancer/presentation/view_model/freelancer_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Freelancer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : widget.freelancer.profileImage != null
                          ? NetworkImage(
                              'http://10.0.2.2:3000/${widget.freelancer.profileImage}')
                          : null,
                  child: _selectedImage == null &&
                          widget.freelancer.profileImage == null
                      ? const Icon(Icons.add_a_photo)
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              if (_isUploading) ...[
                const CircularProgressIndicator(),
                const SizedBox(height: 8),
                const Text('Uploading image...'),
              ],
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _portfolioController,
                decoration: const InputDecoration(labelText: 'Portfolio'),
              ),
              TextField(
                controller: _availabilityController,
                decoration: const InputDecoration(labelText: 'Availability'),
              ),
              TextField(
                controller: _aboutMeController,
                decoration: const InputDecoration(labelText: 'About Me'),
              ),
              TextField(
                controller: _professionController,
                decoration: const InputDecoration(labelText: 'Profession'),
              ),
              TextField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              TextField(
                controller: _workAtController,
                decoration: const InputDecoration(labelText: 'Work At'),
              ),
              TextField(
                controller: _languagesController,
                decoration: const InputDecoration(labelText: 'Languages'),
              ),
              TextField(
                controller: _experienceYearsController,
                decoration:
                    const InputDecoration(labelText: 'Experience Years'),
              ),
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
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveFreelancerDetails,
                child: const Text(
                  'Save Changes',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
