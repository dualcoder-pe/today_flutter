
import 'package:flutter/material.dart';

Widget indicator() {
  return Container(
    width: double.infinity,
    alignment: Alignment.center,
    child: const SizedBox(
        width: 100,
        height: 100,
        child: CircularProgressIndicator()
    ),
  );
}