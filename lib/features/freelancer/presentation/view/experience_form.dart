import 'package:flutter/material.dart';
import 'package:projectsyeti/features/experience/domain/entity/experience_entity.dart';

class ExperienceForm extends StatelessWidget {
  final List<TextEditingController> experienceControllers;
  final List<TextEditingController> companyControllers;
  final List<TextEditingController> fromControllers;
  final List<TextEditingController> toControllers;
  final List<TextEditingController> descriptionControllers;
  final Function addExperience;
  final Function removeExperience;

  const ExperienceForm({
    super.key,
    required this.experienceControllers,
    required this.companyControllers,
    required this.fromControllers,
    required this.toControllers,
    required this.descriptionControllers,
    required this.addExperience,
    required this.removeExperience,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Experience:'),
        if (experienceControllers.isEmpty)
          ElevatedButton(
            onPressed: () => addExperience(),
            child: const Text(
              'Add Experience',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ...List.generate(experienceControllers.length, (index) {
          return Column(
            children: [
              _buildTextField('Experience Title', experienceControllers[index]),
              _buildTextField('Company', companyControllers[index]),
              _buildTextField('From Year', fromControllers[index]),
              _buildTextField('To Year', toControllers[index]),
              _buildTextField('Description', descriptionControllers[index]),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () => removeExperience(index),
              ),
              const SizedBox(height: 16),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[200],
      ),
      maxLines: 1,
    );
  }
}
