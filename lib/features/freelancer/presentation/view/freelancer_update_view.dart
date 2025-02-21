import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectsyeti/features/certification/domain/entity/certification_entity.dart';
import 'package:projectsyeti/features/experience/domain/entity/experience_entity.dart';
import 'package:projectsyeti/features/freelancer/domain/entity/freelancer_entity.dart';
import 'package:projectsyeti/features/freelancer/presentation/view/certification_form.dart';
import 'package:projectsyeti/features/freelancer/presentation/view/experience_form.dart';
import 'package:projectsyeti/features/freelancer/presentation/view_model/freelancer_bloc.dart';

class FreelancerUpdateView extends StatefulWidget {
  final FreelancerEntity freelancer;

  const FreelancerUpdateView({super.key, required this.freelancer});

  @override
  _FreelancerUpdateViewState createState() => _FreelancerUpdateViewState();
}

class _FreelancerUpdateViewState extends State<FreelancerUpdateView> {
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

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing freelancer data
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

    // Initialize certification controllers with existing data
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

    // Initialize experience controllers with existing data
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

  // Function to handle saving/updating freelancer details
  void _saveFreelancerDetails() {
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
      certifications: List.generate(_certificationsControllers.length, (index) {
        return CertificationEntity(
          name: _certificationsControllers[index].text,
          organization: _organizationControllers[index]
              .text, // Dynamic organization field
        );
      }).toList(),
      experience: List.generate(_experienceControllers.length, (index) {
        return ExperienceEntity(
          title: _experienceControllers[index].text,
          company: _companyControllers[index].text, // Dynamic company field
          from: int.tryParse(_fromControllers[index].text) ??
              0, // Dynamic 'from' field
          to: int.tryParse(_toControllers[index].text) ??
              0, // Dynamic 'to' field
          description:
              _descriptionControllers[index].text, // Dynamic description field
        );
      }).toList(),
    );

    context
        .read<FreelancerBloc>()
        .add(UpdateFreelancerEvent(updatedFreelancer));
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
              TextField(
                controller: _profileImageController,
                decoration: const InputDecoration(labelText: 'Profile Image'),
              ),

              // Certification Form
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

              // Experience Form
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
