import 'package:flutter/material.dart';

class SortButton extends StatefulWidget {
  final Function(String) onSortChanged;

  SortButton({required this.onSortChanged});

  @override
  _SortButtonState createState() => _SortButtonState();
}

class _SortButtonState extends State<SortButton> {
  String _selectedSort = '날짜순';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedSort,
              icon: Icon(Icons.arrow_drop_down),
              items: <String>['날짜순', '제목순', '지역순'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedSort = newValue!;
                });
                widget.onSortChanged(_selectedSort);
              },
            ),
          ),
        ],
      ),
    );
  }
}
