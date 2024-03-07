import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grid_touch_animation/grid_matrix.dart';
import 'package:grid_touch_animation/sensor.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final crossAxisCount = 20;
  final mainAxisCount = 40;
  final gridMatrixDecrease = 0.04;
  final gridMatrixIncrease = 0.8;
  final gridMatrixIncreaseNeighbour = 0.4;
  final backgroundColor = const Color(0xff1d2b53);

  late GridMatrix matrix;

  @override
  void initState() {
    super.initState();

    matrix = GridMatrix(
      rows: mainAxisCount,
      columns: crossAxisCount,
      min: 0,
      max: 1,
    );

    Timer.periodic(const Duration(milliseconds: 10), (_) {
      setState(() {
        matrix.decreaseAll(gridMatrixDecrease);
      });
    });
  }

  void onDrag(dynamic details) {
    setState(() {
      final selected = _findIndexByOffset(details.globalPosition);
      matrix.increase(
        index: selected,
        value: gridMatrixIncrease,
      );
      matrix.increaseNeighbours(
        index: selected,
        value: gridMatrixIncreaseNeighbour,
      );
    });
  }

  int _findIndexByOffset(Offset offset) {
    final RenderBox gridRenderBox = context.findRenderObject() as RenderBox;
    final localOffset = gridRenderBox.globalToLocal(offset);

    final size = MediaQuery.sizeOf(context);
    final column = (localOffset.dx / (size.width / crossAxisCount)).floor();
    final row = (localOffset.dy / (size.height / mainAxisCount)).floor();

    return row * crossAxisCount + column;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: GestureDetector(
            onHorizontalDragUpdate: onDrag,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: mainAxisCount * crossAxisCount,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Sensor(intensity: matrix.getValueByIndex(index));
              },
            ),
          ),
        ),
      ),
    );
  }
}
