import 'package:flutter/material.dart';
import 'package:projectsyeti/features/project/domain/entity/project_entity.dart';

class BidProjectCard extends StatelessWidget {
  final ProjectEntity project;

  const BidProjectCard({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: isDarkTheme ? Colors.grey[900] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: isDarkTheme ? Colors.grey[400] : Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatDate(project.postedDate),
                      style: TextStyle(
                        fontSize: 14,
                        color:
                            isDarkTheme ? Colors.grey[400] : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(project.status),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    project.status.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: project.companyLogo.isNotEmpty
                        ? Image.network(
                            "http://192.168.1.70:3000/${project.companyLogo}",
                            fit: BoxFit.cover,
                          )
                        : Image.asset("assets/images/default_company.png"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.companyName,
                        style: TextStyle(
                          fontSize: 16,
                          color: isDarkTheme ? Colors.grey[400] : Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        project.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkTheme ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: project.category.map((category) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF001F3F),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: isDarkTheme ? Colors.grey[400] : Colors.grey,
                ),
                const SizedBox(width: 4),
                Text(
                  "${project.duration} months",
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkTheme ? Colors.grey[400] : Colors.grey[700],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'posted':
        return Colors.green;
      case 'in progress':
        return Colors.orange;
      case 'completed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
