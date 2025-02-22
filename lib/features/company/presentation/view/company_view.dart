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
    return 'http://10.0.2.2:3000/$logoPath';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Details'),
      ),
      body: BlocBuilder<CompanyBloc, CompanyState>(
        builder: (context, state) {
          if (state is CompanyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CompanyLoaded) {
            return _buildCompanyDetails(state.company);
          } else if (state is CompanyError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          }
          return const Center(child: Text("No Company Data Available"));
        },
      ),
    );
  }

  Widget _buildCompanyDetails(CompanyEntity company) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // COMPANY HEADER
            Container(
              padding: const EdgeInsets.all(20),
              decoration: _boxDecoration(),
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
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (company.headquarters != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on,
                            size: 18, color: Colors.blue),
                        const SizedBox(width: 6),
                        Text(
                          company.headquarters!,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black87),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // PROJECTS SECTION (Moved Above Bio)
            const Text(
              "Projects",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildColoredStatCard("Posted",
                    company.projectsPosted.toString(), Colors.blue.shade50),
                _buildColoredStatCard("Awarded",
                    company.projectsAwarded.toString(), Colors.green.shade50),
                _buildColoredStatCard(
                    "Completed",
                    company.projectsCompleted.toString(),
                    Colors.yellow.shade50),
              ],
            ),

            const SizedBox(height: 16),

            // BIO SECTION (Now Below Projects)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: _boxDecoration(),
              child: Text(
                company.companyBio ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),

            const SizedBox(height: 16),

            // OTHER DETAILS SECTION
            Container(
              padding: const EdgeInsets.all(18),
              decoration: _boxDecoration(),
              child: Column(
                children: [
                  _buildDetailRow(Icons.calendar_today, "Founded",
                      company.founded?.toString() ?? "N/A"),
                  _buildDetailRow(Icons.person, "CEO", company.ceo ?? "N/A"),
                  _buildDetailRow(
                      Icons.business, "Industry", company.industry ?? "N/A"),
                  _buildDetailRow(
                      Icons.people, "Employees", company.employees.toString()),
                  _buildDetailRow(
                      Icons.public, "Website", company.website ?? "N/A"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Individual colored cards for stats
  Widget _buildColoredStatCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
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
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  // Row for other details with icons
  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Colors.blue),
          const SizedBox(width: 12),
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  // Box decoration for sections
  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 8,
          spreadRadius: 2,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
