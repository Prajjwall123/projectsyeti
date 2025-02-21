import 'package:flutter/material.dart';

class CertificationForm extends StatelessWidget {
  final List<TextEditingController> certificationsControllers;
  final List<TextEditingController> organizationControllers;
  final Function addCertification;
  final Function removeCertification;

  const CertificationForm({
    super.key,
    required this.certificationsControllers,
    required this.organizationControllers,
    required this.addCertification,
    required this.removeCertification,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Certifications:'),
        if (certificationsControllers.isEmpty)
          ElevatedButton(
            onPressed: () => addCertification(),
            child: const Text(
              'Add Certification',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ...List.generate(certificationsControllers.length, (index) {
          return Column(
            children: [
              _buildTextField(
                  'Certification Name', certificationsControllers[index]),
              _buildTextField('Organization', organizationControllers[index]),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () => removeCertification(index),
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
