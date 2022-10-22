import 'package:digit_recognition_canvas_mobile_app/canvas/models/drawn_line.dart';
import 'package:digit_recognition_canvas_mobile_app/canvas/painters/sketcher.dart';
import 'package:flutter/material.dart';

class DrawingArea extends StatelessWidget {
  const DrawingArea({
    Key? key,
    required this.width,
    required this.height,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
    required this.currentlyDrawnLine,
    required this.allDrawnLines,
  }) : super(key: key);

  final double width;
  final double height;
  final void Function(DragStartDetails) onPanStart;
  final void Function(DragUpdateDetails) onPanUpdate;
  final void Function(DragEndDetails) onPanEnd;
  final DrawnLine? currentlyDrawnLine;
  final List<DrawnLine> allDrawnLines;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        margin: const EdgeInsets.all(0),
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: GestureDetector(
            onPanStart: onPanStart,
            onPanUpdate: onPanUpdate,
            onPanEnd: onPanEnd,
            child: RepaintBoundary(
              child: Container(
                color: Colors.transparent,
                child: CustomPaint(
                  painter: Sketcher(
                    lines: currentlyDrawnLine != null
                        ? (List.of(allDrawnLines)..add(currentlyDrawnLine!))
                        : allDrawnLines,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                    width: 10.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
