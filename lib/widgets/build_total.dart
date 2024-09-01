import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/widgets/build_icon_rounded_add.dart';

class BuildTotal extends StatelessWidget {
  const BuildTotal({
    super.key,
    this.total,
    this.onPressed, // Membuat onPressed opsional
  });

  final String? total;
  final VoidCallback? onPressed; // Mengubah onPressed menjadi nullable

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
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
                // Hanya tampilkan BuildIconRoundedAdd jika onPressed tidak null
                if (onPressed != null)
                  BuildIconRoundedAdd(
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
