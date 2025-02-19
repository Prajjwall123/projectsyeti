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
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (company.logo != null)
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_getFullLogoUrl(company.logo!)),
                  radius: 60,
                ),
              ),
            const SizedBox(height: 20),
            _buildStyledDetail("Company Name", company.companyName),
            _buildStyledDetail("Bio", company.companyBio ?? "N/A"),
            _buildStyledDetail("Employees", company.employees.toString()),
            _buildStyledDetail(
                "Projects Posted", company.projectsPosted.toString()),
            _buildStyledDetail(
                "Projects Awarded", company.projectsAwarded.toString()),
            _buildStyledDetail(
                "Projects Completed", company.projectsCompleted.toString()),
            _buildStyledDetail("Founded", company.founded?.toString() ?? "N/A"),
            _buildStyledDetail("CEO", company.ceo ?? "N/A"),
            _buildStyledDetail("Headquarters", company.headquarters ?? "N/A"),
            _buildStyledDetail("Industry", company.industry ?? "N/A"),
            _buildStyledDetail("Website", company.website ?? "N/A"),
          ],
        ),
      ),
    );
  }

  Widget _buildStyledDetail(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.blue,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
