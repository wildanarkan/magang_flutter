import 'package:flutter/material.dart';
import 'package:nextbasis_hris/common/app_color.dart';
import 'package:nextbasis_hris/widgets/buttons/build_button_rounded.dart';

class BuildTotal extends StatelessWidget {
  const BuildTotal({
    super.key,
    this.total,
    this.onPressed, this.padding,
  });

  final String? total;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed; // Mengubah onPressed menjadi nullable

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(color: AppColor.textBody),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      total ?? 'IDR 0',
                      style: TextStyle(
                        color: AppColor.textTitle,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                // Hanya tampilkan BuildButtonRounded jika onPressed tidak null
                if (onPressed != null)
                  BuildButtonRounded(
                    onPressed: onPressed!,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
