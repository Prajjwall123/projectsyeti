import 'package:flutter/material.dart';

class VoucherCard extends StatelessWidget {
  final String title;
  final String description;
  final Color backgroundColor;

  const VoucherCard({
    super.key,
    required this.title,
    required this.description,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
