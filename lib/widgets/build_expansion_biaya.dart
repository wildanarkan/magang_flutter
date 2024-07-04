import 'package:flutter/material.dart';
import 'package:magang_flutter/widgets/build_expansion_tile.dart';

class BuildExpansionBiaya extends StatelessWidget {
  const BuildExpansionBiaya({
    super.key,
    required this.title,
    this.subtitle,
    this.children,
  });

  final Widget title;
  final Widget? subtitle;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: VExpansionTile(
          childrenPadding: const EdgeInsets.all(0),
          tilePadding: EdgeInsets.zero,
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          initiallyExpanded: false,
          title: title,
          biayaExpansion: true,
          subtitle: subtitle,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: children ?? [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
