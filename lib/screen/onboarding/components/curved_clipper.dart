import 'package:flutter/material.dart';

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Move to the starting point of the curve
    path.moveTo(0, size.height * 0.8);

    // Create a quadratic bezier curve to form a semi-circle
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height * 0.8);

    // Line to the bottom-right corner
    path.lineTo(size.width, size.height);

    // Line to the bottom-left corner
    path.lineTo(0, size.height);

    // Close the path to create the shape
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
