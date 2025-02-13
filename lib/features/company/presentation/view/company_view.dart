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
    debugPrint('http://10.0.2.2:3000/$logoPath');
    return 'http://10.0.2.2:3000/$logoPath';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<CompanyBloc, CompanyState>(
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
      ),
    );
  }

  Widget _buildCompanyDetails(CompanyEntity company) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (company.logo != null)
            Center(
              child: Image.network(
                _getFullLogoUrl(company.logo!),
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 20),
          _buildDetailRow("Company Name", company.companyName),
          _buildDetailRow("Bio", company.companyBio ?? "N/A"),
          _buildDetailRow("Employees", company.employees.toString()),
          _buildDetailRow("Projects Posted", company.projectsPosted.toString()),
          _buildDetailRow(
              "Projects Awarded", company.projectsAwarded.toString()),
          _buildDetailRow(
              "Projects Completed", company.projectsCompleted.toString()),
          _buildDetailRow("Founded", company.founded?.toString() ?? "N/A"),
          _buildDetailRow("CEO", company.ceo ?? "N/A"),
          _buildDetailRow("Headquarters", company.headquarters ?? "N/A"),
          _buildDetailRow("Industry", company.industry ?? "N/A"),
          _buildDetailRow("Website", company.website ?? "N/A"),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
