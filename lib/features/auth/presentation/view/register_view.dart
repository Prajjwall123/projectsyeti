import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:projectsyeti/features/auth/presentation/view_model/bloc/register_bloc.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';
import 'package:projectsyeti/features/skill/presentation/view_model/bloc/skill_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _gap = const SizedBox(height: 8);
  final _key = GlobalKey<FormState>();
  final _freelancerNameController = TextEditingController();
  final _portfolioController = TextEditingController();
  final _emailController = TextEditingController();
  final _experienceController = TextEditingController();
  final _availabilityController = TextEditingController();
  final _passwordController = TextEditingController();

  SkillEntity? _dropDownValue;
  final List<SkillEntity> _selectedSkills = [];

  File? _img;
  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          context.read<RegisterBloc>().add(
                UploadImage(file: _img!),
              );
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Check for camera permission
  Future<void> checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Freelancer'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.grey[300],
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  checkCameraPermission();
                                  _browseImage(ImageSource.camera);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.camera),
                                label: const Text('Camera'),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  _browseImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.image),
                                label: const Text('Gallery'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: _img != null
                            ? FileImage(_img!)
                            : const AssetImage(
                                    'assets/images/default_avatar.png')
                                as ImageProvider,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: _freelancerNameController,
                    decoration: const InputDecoration(
                      labelText: 'Freelancer Name',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter freelancer name';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  TextFormField(
                    controller: _portfolioController,
                    decoration: const InputDecoration(
                      labelText: 'Portfolio URL',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter portfolio URL';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  TextFormField(
                    controller: _experienceController,
                    decoration: const InputDecoration(
                      labelText: 'Experience (in years)',
                    ),
                    keyboardType: TextInputType.number,
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter experience years';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  BlocBuilder<SkillBloc, SkillState>(
                      builder: (context, skillState) {
                    return MultiSelectDialogField(
                      title: const Text('Select Skills'),
                      items: skillState.skills
                          .map(
                            (skill) => MultiSelectItem(
                              skill,
                              skill.name,
                            ),
                          )
                          .toList(),
                      listType: MultiSelectListType.CHIP,
                      buttonText: const Text(
                        'Select Skills',
                        style: TextStyle(color: Colors.black),
                      ),
                      buttonIcon: const Icon(Icons.search),
                      onConfirm: (values) {
                        _selectedSkills.clear();
                        _selectedSkills.addAll(values);
                      },
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black87,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select skills';
                        }
                        return null;
                      }),
                    );
                  }),
                  _gap,
                  TextFormField(
                    controller: _availabilityController,
                    decoration: const InputDecoration(
                      labelText: 'Availability (e.g., Full-time)',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter availability';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          // Create a new freelancer registration event
                          final freelancerName = _freelancerNameController.text;
                          final portfolio = _portfolioController.text;
                          final email = _emailController.text;
                          final experienceYears =
                              int.parse(_experienceController.text);
                          final availability = _availabilityController.text;
                          final password = _passwordController.text;
                          final profileImage = _img?.path ?? "";

                          // Dispatch an event to register the freelancer
                          context.read<RegisterBloc>().add(
                                RegisterUser(
                                  context: context,
                                  freelancerName: freelancerName,
                                  portfolio: portfolio,
                                  email: email,
                                  experienceYears: experienceYears,
                                  skills: _selectedSkills,
                                  availability: availability,
                                  password: password,
                                  profileImage: profileImage,
                                ),
                              );
                        }
                      },
                      child: const Text('Register'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
