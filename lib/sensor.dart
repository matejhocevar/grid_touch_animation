import 'package:flutter/material.dart';

class Sensor extends StatelessWidget {
  const Sensor({super.key, this.intensity = 0.0});

  final double intensity;

  @override
  Widget build(BuildContext context) {
    Color? shadowColor;
    if (intensity > 0.75) {
      shadowColor = const Color(0xfffaef5d);
    } else if (intensity > 0.25) {
      shadowColor = const Color(0xffff004d);
    } else {
      shadowColor = const Color(0xff7e2553);
    }

    List<BoxShadow>? shadow = [
      BoxShadow(
        color: shadowColor.withOpacity(intensity),
        spreadRadius: 10 * intensity,
        blurRadius: 16 * intensity,
      ),
    ];

    return RepaintBoundary(
      child: LayoutBuilder(builder: (context, constraints) {
        return Center(
          child: Container(
            width: constraints.maxWidth / 4,
            height: constraints.maxHeight / 4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: intensity == 0 ? Colors.black12 : shadowColor,
              boxShadow: shadow,
            ),
          ),
        );
      }),
    );
  }
}
