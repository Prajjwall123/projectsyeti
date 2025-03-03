import 'package:flutter/material.dart';
import 'package:projectsyeti/features/project/domain/entity/project_entity.dart';

class ProjectStatusCard extends StatefulWidget {
  final ProjectEntity project;
  final Function(String) onStatusChanged;

  const ProjectStatusCard(
      {super.key, required this.project, required this.onStatusChanged});

  @override
  _ProjectStatusCardState createState() => _ProjectStatusCardState();
}

class _ProjectStatusCardState extends State<ProjectStatusCard> {
  late String selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.project.status;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // **Project Title**
            Text(
              widget.project.title,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),

            // **Dropdown to Change Status**
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // **Status Dropdown**
                DropdownButton<String>(
                  value: selectedStatus,
                  items: _statusOptions.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (newStatus) {
                    if (newStatus != null) {
                      setState(() {
                        selectedStatus = newStatus;
                      });
                      widget.onStatusChanged(newStatus);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// **List of Available Status Options**
  final List<String> _statusOptions = [
    "awarded",
    "In Progress",
    "Feedback Requested",
    "Completed",
  ];
}
