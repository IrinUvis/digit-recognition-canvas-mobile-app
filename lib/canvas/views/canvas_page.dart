import 'package:digit_recognition_canvas_mobile_app/canvas/bloc/canvas_bloc.dart';
import 'package:digit_recognition_canvas_mobile_app/canvas/widgets/drawing_area.dart';
import 'package:digit_recognition_canvas_mobile_app/util/widgets/filled_tonal_button.dart';
import 'package:digit_recognition_canvas_mobile_app/util/widgets/screen_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CanvasPage extends StatelessWidget {
  const CanvasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CanvasBloc(),
      child: const CanvasView(),
    );
  }
}

class CanvasView extends StatelessWidget {
  const CanvasView({Key? key}) : super(key: key);

  static const horizontalPadding = 16.0;
  final Color selectedColor = Colors.white;
  final double selectedWidth = 5.0;

  @override
  Widget build(BuildContext context) {
    final canvasSize =
        MediaQuery.of(context).size.width - 2 * horizontalPadding;

    return Scaffold(
      body: BlocBuilder<CanvasBloc, CanvasState>(
        builder: (context, state) {
          return ScreenPadding(
            child: Padding(
              padding: const EdgeInsets.all(horizontalPadding),
              child: Column(
                // global key?
                children: [
                  DrawingArea(
                    width: canvasSize,
                    height: canvasSize,
                    onPanStart: (details) => onPanStart(details, context),
                    onPanUpdate: (details) => onPanUpdate(details, context),
                    onPanEnd: (details) => onPanEnd(details, context),
                    currentlyDrawnLine: state.currentlyDrawnLine,
                    allDrawnLines: state.allDrawnLines,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton.icon(
                          onPressed: () => context
                              .read<CanvasBloc>()
                              .add(const CanvasCleared()),
                          icon: const Icon(Icons.clear),
                          label: const Text('Clear'),
                        ),
                        FilledTonalButton(
                          onPressed: () => context
                              .read<CanvasBloc>()
                              .add(const CanvasDrawingChecked()),
                          icon: Icons.check,
                          label: const Text('Check'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void onPanStart(DragStartDetails details, BuildContext context) {
    final point = details.localPosition;
    context.read<CanvasBloc>().add(CanvasDrawingStarted(firstPoint: point));
  }

  void onPanUpdate(DragUpdateDetails details, BuildContext context) {
    final point = details.localPosition;
    context.read<CanvasBloc>().add(CanvasDrawingInProgress(newPoint: point));
  }

  void onPanEnd(DragEndDetails details, BuildContext context) {
    context.read<CanvasBloc>().add(const CanvasDrawingFinished());
  }
}
