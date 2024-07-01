import 'package:flutter/material.dart';

class BuildShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50); // Pindah ke kiri bawah, naik 50 unit
    path.quadraticBezierTo(
      size.width / 2, size.height + 50, // Kontrol titik di bawah tengah
      size.width, size.height - 50, // Akhir garis di kanan bawah, naik 50 unit
    );
    path.lineTo(size.width, 0); // Pindah ke kanan atas
    path.lineTo(0, 0); // Pindah ke kiri atas
    path.close(); // Tutup path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
