import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectsyeti/app/widgets/bid_project_card.dart';
import 'package:projectsyeti/features/bidding/presentation/viewmodel/bidding_bloc.dart';
import 'package:projectsyeti/features/project/domain/entity/project_entity.dart';
import 'package:projectsyeti/features/project/presentation/view_model/bloc/project_bloc.dart';

class BidSubmissionView extends StatefulWidget {
  final String projectId;
  final String freelancerId;

  const BidSubmissionView({
    super.key,
    required this.projectId,
    required this.freelancerId,
  });

  @override
  State<BidSubmissionView> createState() => _BidSubmissionViewState();
}

class _BidSubmissionViewState extends State<BidSubmissionView> {
  late TextEditingController _bidAmountController;
  late TextEditingController _proposalController;
  File? _selectedFile;

  @override
  void initState() {
    super.initState();
    _bidAmountController = TextEditingController();
    _proposalController = TextEditingController();

    // Fetch project details when page loads
    context.read<ProjectBloc>().add(GetProjectByIdEvent(widget.projectId));
  }

  @override
  void dispose() {
    _bidAmountController.dispose();
    _proposalController.dispose();
    super.dispose();
  }

  // 📌 Function to Pick a File
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Submit Bid")),
      body: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) {
          if (state is ProjectLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProjectLoaded) {
            return _buildBidForm(state.project);
          } else if (state is ProjectError) {
            return Center(
              child: Text(state.message,
                  style: const TextStyle(color: Colors.red, fontSize: 18)),
            );
          }
          return const Center(child: Text("Project details not available"));
        },
      ),
    );
  }

  Widget _buildBidForm(ProjectEntity project) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Display the BidProjectCard component with project details
          BidProjectCard(project: project),

          const SizedBox(height: 20),

          // ✅ Bid Amount Input
          const Text("Bid Amount",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _bidAmountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter your bid amount",
              filled: true,
              fillColor: Colors.grey[100], // Light background
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ✅ Proposal Input
          const Text("Proposal",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _proposalController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Write your proposal...",
              filled: true,
              fillColor: Colors.grey[100], // Light background
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ✅ File Upload Button
          const Text("Attach File",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _pickFile,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.blue, // Dark blue like buttons
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.attach_file, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _selectedFile != null
                          ? _selectedFile!.path.split('/').last
                          : "No file selected",
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity, // Full width button
            child: ElevatedButton(
              onPressed: () {
                if (_bidAmountController.text.isEmpty ||
                    _proposalController.text.isEmpty ||
                    _selectedFile == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text("Please fill all fields and attach a file")),
                  );
                  return;
                }

                context.read<BiddingBloc>().add(CreateBidEvent(
                      freelancer: widget.freelancerId, // Freelancer ID passed
                      project: widget.projectId,
                      amount: double.parse(_bidAmountController.text),
                      message: _proposalController.text,
                      file: _selectedFile!,
                    ));
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 16), // Bigger button
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                backgroundColor: const Color(0xFF001F3F), // Dark blue theme
              ),
              child: const Text(
                "Submit Bid",
                style: TextStyle(
                  fontSize: 18, // Bigger text
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
