import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.8); // Start higher up
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height * 0.9);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    var secondControlPoint = Offset(size.width * 3 / 4, size.height * 0.8);
    var secondEndPoint = Offset(size.width, size.height * 0.95);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0); // Line to top right
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height);

    var firstControlPoint = Offset(size.width / 4, size.height - 30);
    var firstPoint = Offset(size.width / 2, size.height - 10);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstPoint.dx,
      firstPoint.dy,
    );

    var secondControlPoint = Offset(size.width * 3 / 4, size.height + 10);
    var secondPoint = Offset(size.width, size.height - 20);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondPoint.dx,
      secondPoint.dy,
    );

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height * 0.8); // Diagonal line
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class HeartClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(size.width / 2, size.height * 0.4);
    path.cubicTo(
      size.width / 2 + size.width * 0.5,
      size.height * 0.0, // Control point 1
      size.width,
      size.height * 0.8, // Control point 2
      size.width / 2,
      size.height, // End point
    );
    path.cubicTo(
      size.width * 0.0,
      size.height * 0.8, // Control point 3
      size.width / 2 - size.width * 0.5,
      size.height * 0.0, // Control point 4
      size.width / 2,
      size.height * 0.4, // End point
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
