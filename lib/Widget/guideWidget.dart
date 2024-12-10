import 'package:flutter/material.dart';

ExpansionPanel buildPanel({
  required int index,
  required bool isExpanded,
  required ValueChanged<bool> onToggle,
  required String title,
  required String description,
  required String concept,
  required String hashtags,
  Color? backgroundColor,
}) {
  return ExpansionPanel(
    headerBuilder: (context, isExpanded) {
      return Container(
        color: backgroundColor,
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              hashtags,
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
          ],
        ),
      );
    },
    body: Container(
      color: backgroundColor,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            hashtags,
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
        ],
      ),
    ),
    isExpanded: isExpanded,
    canTapOnHeader: true,
  );
}
