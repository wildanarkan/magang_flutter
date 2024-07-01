import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final ImageProvider imageProvider;
  final AlignmentGeometry imageAlignment;
  final Widget child;

  const BackgroundImage({
    super.key,
    required this.imageProvider,
     this.imageAlignment = const Alignment(0, 0), required this.child,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.fitHeight,
          alignment: imageAlignment,
          colorFilter: const ColorFilter.mode(Color.fromARGB(158, 0, 0, 0), BlendMode.darken),
        ),
      ),
      child: child,
    );
  }
}
