
import 'package:flutter/material.dart';

Widget TextClearSuffixIcon(TextEditingController controller) {
  return SizedBox(
    height: 20.0,
    width: 20.0,
    child: IconButton(
      constraints: const BoxConstraints(maxWidth: 20, maxHeight: 20),
      onPressed: () => controller.clear(),
      padding: const EdgeInsets.all(0.0),
      iconSize: 18,
      color: Colors.greenAccent,
      icon: Icon(
        Icons.clear,
        color: Colors.grey.shade600,
      ),
    ),
  );
}