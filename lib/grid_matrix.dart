import 'dart:ui';

import 'package:matrices/matrices.dart';

typedef Position = (int row, int column);

class GridMatrix {
  GridMatrix({
    required this.rows,
    required this.columns,
    this.initial = 0,
    this.min = double.negativeInfinity,
    this.max = double.infinity,
  }) {
    _matrix = Matrix.number(initial, rows, columns);
  }

  final int rows;
  final int columns;
  final double initial;
  final double min;
  final double max;

  late Matrix _matrix;

  Position getPositionFromIndex(int index) {
    int row = (index / columns).floor();
    int column = index % columns;
    return (row, column);
  }

  double getValueByIndex(int index) {
    final position = getPositionFromIndex(index);
    return _matrix[position.$1][position.$2];
  }

  void increase({required int index, required double value}) {
    final position = getPositionFromIndex(index);
    _matrix[position.$1][position.$2] += value;
    _clampPosition(position);
  }

  void increaseNeighbours({required int index, required double value}) {
    // Top
    final top = index - columns;
    if (top >= 0) {
      increase(index: top, value: value);
    }

    // Bottom
    final bottom = index + columns;
    if (bottom < rows * columns) {
      increase(index: bottom, value: value);
    }

    // Left
    final left = index - 1;
    if (left >= 0 && left % columns != columns - 1) {
      increase(index: left, value: value);
    }

    // Right
    final right = index + 1;
    if (right < rows * columns && right % columns != 0) {
      increase(index: right, value: value);
    }
  }

  void decreaseAll(double value) {
    _matrix -= value;
    _clampMatrix();
  }

  void _clampPosition(Position position) {
    _matrix[position.$1][position.$2] = clampDouble(
      _matrix[position.$1][position.$2],
      min,
      max,
    );
  }

  void _clampMatrix() {
    for (int i = 0; i < rows * columns; i++) {
      final position = getPositionFromIndex(i);
      _clampPosition(position);
    }
  }
}
