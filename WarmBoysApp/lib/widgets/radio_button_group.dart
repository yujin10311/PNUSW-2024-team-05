import 'package:flutter/material.dart';

class RadioButtonGroup extends StatelessWidget {
  final String label;
  final List<String> options;
  final String groupValue;
  final Function(String) onChanged;

  RadioButtonGroup({
    required this.label,
    required this.options,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Row를 가로축에서 가운데로 정렬
            children: options.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: option,
                      groupValue: groupValue,
                      onChanged: (value) {
                        onChanged(value!);
                      },
                    ),
                    Text(option),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
