import 'package:flutter/material.dart';

class MemberSymptomScrollview extends StatelessWidget {
  final List<String> symptoms;

  MemberSymptomScrollview({required this.symptoms});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: symptoms.map((symptom) {
            return Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(symptom, style: TextStyle(fontSize: 18)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
