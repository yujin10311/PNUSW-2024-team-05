import 'package:flutter/material.dart';

class ActivityTypeScrollView extends StatelessWidget {
  final List<String> activityTypes;

  const ActivityTypeScrollView({
    Key? key,
    required this.activityTypes,
  }) : super(key: key);

  IconData _getActivityIcon(String activity) {
    switch (activity) {
      case '실내활동':
        return Icons.home;
      case '실외활동':
        return Icons.nature;
      case '밥 챙겨주기':
        return Icons.restaurant;
      case '책 읽기':
        return Icons.book;
      case '재능 기부':
        return Icons.volunteer_activism;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: activityTypes.map((activity) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Icon(
                  _getActivityIcon(activity),
                  size: 40,
                ),
                SizedBox(height: 5),
                Text(
                  activity,
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
