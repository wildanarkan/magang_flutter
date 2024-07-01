import 'package:flutter/material.dart';

class BuildRowicon extends StatelessWidget {
  const BuildRowicon({
    super.key, 
    required this.title, 
    required this.icon,
    required this.onTap,
    this.iconColor,
  });

  final String title;
  final IconData? icon;
  final VoidCallback onTap;
  final Color? iconColor;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30 ,vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                 if (icon != null) Icon(
                   icon, size: 24,
                   color: iconColor,), // Tampilkan icon jika tidak null
                if (icon != null) 
                const SizedBox(width: 20),
                 Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14
                  ),
                )
              ],
            ),
            const Icon(Icons.arrow_forward_ios,
            size: 20,)
          ],
        ),
      ),
    );
  }}