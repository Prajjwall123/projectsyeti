import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectsyeti/features/auth/presentation/view_model/bloc/register_bloc.dart';

class OtpView extends StatefulWidget {
  final String email;  // ✅ Store email in OtpView

  const OtpView({super.key, required this.email});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify OTP")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Enter the OTP sent to your email",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "OTP",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, state) {
                if (state.isOtpVerified) {
                  Navigator.pop(context); // Navigate back to Login
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: state.isLoading
                      ? null
                      : () {
                          context.read<RegisterBloc>().add(
                                VerifyOtp(
                                  otp: _otpController.text,
                                  email: widget.email, // ✅ Pass email from OtpView
                                  context: context,
                                ),
                              );
                        },
                  child: state.isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Verify OTP"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
