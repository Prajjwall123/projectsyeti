import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectsyeti/features/company/domain/entity/company_entity.dart';
import 'package:projectsyeti/features/company/presentation/view_model/bloc/company_bloc.dart';

class CompanyView extends StatefulWidget {
  final String companyId;

  const CompanyView({super.key, required this.companyId});

  @override
  State<CompanyView> createState() => _CompanyViewState();
}

class _CompanyViewState extends State<CompanyView> {
  @override
  void initState() {
    super.initState();
    context.read<CompanyBloc>().add(GetCompanyByIdEvent(widget.companyId));
  }

  String _getFullLogoUrl(String logoPath) {
    if (logoPath.startsWith('http://') || logoPath.startsWith('https://')) {
      return logoPath;
    }
    return 'http://192.168.1.70:3000/$logoPath';
  }

  @override
  Widget build(BuildContext context) {
    // Determine if the theme is dark
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Details'),
        // AppBar will automatically adapt to the theme
      ),
      body: BlocBuilder<CompanyBloc, CompanyState>(
        builder: (context, state) {
          if (state is CompanyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CompanyLoaded) {
            return _buildCompanyDetails(state.company, isDarkTheme);
          } else if (state is CompanyError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(
                  color: isDarkTheme ? Colors.red[300] : Colors.red,
                  fontSize: 18,
                ),
              ),
            );
          }
          return Center(
            child: Text(
              "No Company Data Available",
              style: TextStyle(
                color: isDarkTheme ? Colors.white70 : Colors.black54,
                fontSize: 18,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCompanyDetails(CompanyEntity company, bool isDarkTheme) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // COMPANY HEADER
            Container(
              padding: const EdgeInsets.all(20),
              decoration: _boxDecoration(isDarkTheme),
              child: Column(
                children: [
                  if (company.logo != null)
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(_getFullLogoUrl(company.logo!)),
                      radius: 70,
                    ),
                  const SizedBox(height: 12),
                  Text(
                    company.companyName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDarkTheme ? Colors.white : Colors.black,
                    ),
                  ),
                  if (company.headquarters != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 18,
                          color: isDarkTheme ? Colors.blue[300] : Colors.blue,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          company.headquarters!,
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                isDarkTheme ? Colors.grey[400] : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // PROJECTS SECTION
            Text(
              "Projects",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildColoredStatCard(
                  "Posted",
                  company.projectsPosted.toString(),
                  isDarkTheme ? Colors.blue[900]! : Colors.blue.shade50,
                  isDarkTheme,
                ),
                _buildColoredStatCard(
                  "Awarded",
                  company.projectsAwarded.toString(),
                  isDarkTheme ? Colors.green[900]! : Colors.green.shade50,
                  isDarkTheme,
                ),
                _buildColoredStatCard(
                  "Completed",
                  company.projectsCompleted.toString(),
                  isDarkTheme ? Colors.yellow[900]! : Colors.yellow.shade50,
                  isDarkTheme,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // BIO SECTION
            Container(
              padding: const EdgeInsets.all(18),
              decoration: _boxDecoration(isDarkTheme),
              child: Text(
                company.companyBio ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkTheme ? Colors.white70 : Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // OTHER DETAILS SECTION
            Container(
              padding: const EdgeInsets.all(18),
              decoration: _boxDecoration(isDarkTheme),
              child: Column(
                children: [
                  _buildDetailRow(
                    Icons.calendar_today,
                    "Founded",
                    company.founded?.toString() ?? "N/A",
                    isDarkTheme,
                  ),
                  _buildDetailRow(
                    Icons.person,
                    "CEO",
                    company.ceo ?? "N/A",
                    isDarkTheme,
                  ),
                  _buildDetailRow(
                    Icons.business,
                    "Industry",
                    company.industry ?? "N/A",
                    isDarkTheme,
                  ),
                  _buildDetailRow(
                    Icons.people,
                    "Employees",
                    company.employees.toString(),
                    isDarkTheme,
                  ),
                  _buildDetailRow(
                    Icons.public,
                    "Website",
                    company.website ?? "N/A",
                    isDarkTheme,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Individual colored cards for stats
  Widget _buildColoredStatCard(
      String label, String value, Color color, bool isDarkTheme) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isDarkTheme
                  ? Colors.black.withOpacity(0.3)
                  : Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkTheme ? Colors.white : Colors.blue,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: isDarkTheme ? Colors.white70 : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Row for other details with icons
  Widget _buildDetailRow(
      IconData icon, String label, String value, bool isDarkTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: isDarkTheme ? Colors.blue[300] : Colors.blue,
          ),
          const SizedBox(width: 12),
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: isDarkTheme ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Box decoration for sections
  BoxDecoration _boxDecoration(bool isDarkTheme) {
    return BoxDecoration(
      color: isDarkTheme ? Colors.grey[900] : Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: isDarkTheme
              ? Colors.black.withOpacity(0.3)
              : Colors.grey.withOpacity(0.3),
          blurRadius: 8,
          spreadRadius: 2,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
