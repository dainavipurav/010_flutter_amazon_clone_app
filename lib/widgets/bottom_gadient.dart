import 'package:flutter/material.dart';

class BottomGradient extends StatelessWidget {
  final double height;
  const BottomGradient({
    super.key,
    this.height = 130,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ShaderMask(
        shaderCallback: (rect) {
          return const LinearGradient(
            stops: [0.1, 0.5],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.blue],
          ).createShader(Rect.fromLTRB(1, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            color: Theme.of(context).colorScheme.surface,
            // color: Colors.green,
          ),
          height: height,
        ),
      ),
    );
  }
}
