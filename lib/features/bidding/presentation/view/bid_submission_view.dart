import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectsyeti/app/shared_prefs/token_shared_prefs.dart';
import 'package:projectsyeti/features/bidding/presentation/viewmodel/bidding_bloc.dart';

class BidSubmissionView extends StatefulWidget {
  final String projectId;

  const BidSubmissionView({super.key, required this.projectId});

  @override
  State<BidSubmissionView> createState() => _BidSubmissionViewState();
}

class _BidSubmissionViewState extends State<BidSubmissionView> {
  late TokenSharedPrefs tokenSharedPrefs;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String? _pdfFilePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Your Bid'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project ID: ${widget.projectId}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Bid Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: 'Bid Message',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickPdf,
              child: const Text("Upload PDF"),
            ),
            if (_pdfFilePath != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text("Selected PDF: $_pdfFilePath"),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitBid,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                backgroundColor: Colors.blue,
              ),
              child: const Text("Submit Bid",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  // Pick a PDF file from the user's device
  Future<void> _pickPdf() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      setState(() {
        _pdfFilePath = result.files.single.path;
      });
    }
  }

  void _submitBid() async {
    final amount = _amountController.text.trim();
    final message = _messageController.text.trim();

    if (amount.isEmpty || message.isEmpty || _pdfFilePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please fill in all fields and upload a PDF.")),
      );
      return;
    }

    // Fetch the freelancer ID asynchronously
    final freelancerResult = await tokenSharedPrefs.getUserId();

    freelancerResult.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${failure.message}")),
        );
      },
      (freelancerId) {
        // If freelancerId is fetched successfully, dispatch the CreateBidEvent
        if (freelancerId.isNotEmpty) {
          context.read<BiddingBloc>().add(CreateBidEvent(
                freelancer: freelancerId, // Pass the fetched freelancer ID
                project: widget.projectId, // Use the project ID
                amount: double.parse(amount),
                message: message,
                file: File(_pdfFilePath!), // Pass the correct file
              ));

          // Show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Bid Submitted!")),
          );

          Navigator.pop(context); // Go back after submission
        } else {
          // Handle case where freelancerId is empty
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Error: Freelancer ID is missing.")),
          );
        }
      },
    );
  }
}
