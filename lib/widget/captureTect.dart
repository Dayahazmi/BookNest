// dialog_helper.dart
import 'package:flutter/material.dart';

void showTextDetectedDialog(BuildContext context, String detectedText,
    String title, String description) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            description.isNotEmpty ? description : "No description available.",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            detectedText.isNotEmpty ? detectedText : "No text detected",
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("OK"),
        ),
      ],
    ),
  );
}
