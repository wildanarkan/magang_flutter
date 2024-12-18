import 'package:flutter/material.dart';

class BuildButtonIcon extends StatelessWidget {
  const BuildButtonIcon({
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
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                 if (icon != null) Icon(
                   icon, size: 24,
                   color: iconColor,),
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
            const Icon(Icons.arrow_forward_ios_rounded,
            size: 20,)
          ],
        ),
      ),
    );
  }
}
