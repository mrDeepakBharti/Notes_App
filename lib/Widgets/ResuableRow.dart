import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ResuableRow extends StatelessWidget {
  ResuableRow({super.key, required this.title, required this.onTap});
  final String title;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "dont't Have an Account",
          style: TextStyle(fontSize: 15.0, color: Colors.black),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            title,
            style: TextStyle(fontSize: 15.0, color: Colors.blue),
          ),
        )
      ],
    );
  }
}
