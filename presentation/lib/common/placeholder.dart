
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget SizedPlaceholder(bool showShimmer, double width, double height, Widget child) {
  if(showShimmer) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(width: width, height: height, color: Colors.white),
    );
  } else {
    return child;
  }
}

List<Widget> ListPlaceholder(bool showShimmer, double width, double height, List<Widget> child) {
  if(showShimmer) {
    return [Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(width: width, height: height, color: Colors.white),
    )];
  } else {
    return child;
  }
}