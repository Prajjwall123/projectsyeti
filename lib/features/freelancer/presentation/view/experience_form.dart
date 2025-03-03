import 'package:flutter/material.dart';

class ExperienceForm extends StatelessWidget {
  final List<TextEditingController> experienceControllers;
  final List<TextEditingController> companyControllers;
  final List<TextEditingController> fromControllers;
  final List<TextEditingController> toControllers;
  final List<TextEditingController> descriptionControllers;
  final Function addExperience;
  final Function(int) removeExperience;

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
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (experienceControllers.isEmpty) ...[
          Center(
            child: ElevatedButton(
              onPressed: () => addExperience(),
              style: theme.elevatedButtonTheme.style?.copyWith(
                minimumSize: WidgetStateProperty.all(const Size(200, 48)),
              ),
              child: const Text('Add Experience'),
            ),
          ),
        ],
        ...List.generate(experienceControllers.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Experience Title
                Text(
                  'Experience Title',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: experienceControllers[index],
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

                // Company
                Text(
                  'Company',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: companyControllers[index],
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

                // From Year
                Text(
                  'From Year',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: fromControllers[index],
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
                const SizedBox(height: 16),

                // To Year
                Text(
                  'To Year',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: toControllers[index],
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
                const SizedBox(height: 16),

                // Description
                Text(
                  'Description',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: descriptionControllers[index],
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
                    onPressed: () => removeExperience(index),
                  ),
                ),
              ],
            ),
          );
        }),
        if (experienceControllers.isNotEmpty) ...[
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () => addExperience(),
              style: theme.elevatedButtonTheme.style?.copyWith(
                minimumSize: WidgetStateProperty.all(const Size(200, 48)),
              ),
              child: const Text('Add Another Experience'),
            ),
          ),
        ],
      ],
    );
  }
}
