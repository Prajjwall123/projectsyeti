import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: Text("Inside a card", style: TextStyle(fontSize: 40),)),
    );
  }
}