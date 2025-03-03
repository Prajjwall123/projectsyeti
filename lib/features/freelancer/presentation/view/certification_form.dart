import 'package:flutter/material.dart';

class CertificationForm extends StatelessWidget {
  final List<TextEditingController> certificationsControllers;
  final List<TextEditingController> organizationControllers;
  final Function addCertification;
  final Function(int) removeCertification;

  const CertificationForm({
    super.key,
    required this.certificationsControllers,
    required this.organizationControllers,
    required this.addCertification,
    required this.removeCertification,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (certificationsControllers.isEmpty) ...[
          Center(
            child: ElevatedButton(
              onPressed: () => addCertification(),
              style: theme.elevatedButtonTheme.style?.copyWith(
                minimumSize: WidgetStateProperty.all(const Size(200, 48)),
              ),
              child: const Text('Add Certification'),
            ),
          ),
        ],
        ...List.generate(certificationsControllers.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Certification Name
                Text(
                  'Certification Name',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: certificationsControllers[index],
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

                // Organization
                Text(
                  'Organization',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: organizationControllers[index],
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
                const SizedBox(height: 8),

                // Remove Button
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: theme.colorScheme.error,
                    ),
                    onPressed: () => removeCertification(index),
                  ),
                ),
              ],
            ),
          );
        }),
        if (certificationsControllers.isNotEmpty) ...[
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () => addCertification(),
              style: theme.elevatedButtonTheme.style?.copyWith(
                minimumSize: WidgetStateProperty.all(const Size(200, 48)),
              ),
              child: const Text('Add Another Certification'),
            ),
          ),
        ],
      ],
    );
  }
}
