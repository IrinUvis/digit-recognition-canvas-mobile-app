import 'package:digit_recognition_canvas_mobile_app/canvas/bloc/canvas_bloc.dart';
import 'package:digit_recognition_canvas_mobile_app/canvas/widgets/canvas_buttons.dart';
import 'package:digit_recognition_canvas_mobile_app/canvas/widgets/drawing_area.dart';
import 'package:digit_recognition_canvas_mobile_app/canvas/widgets/toggle_theme_button.dart';
import 'package:digit_recognition_canvas_mobile_app/theme/bloc/theme_cubit.dart';
import 'package:digit_recognition_canvas_mobile_app/util/widgets/screen_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/prediction_details_summary.dart';

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
  static const strokeWidth = 20.0;

  @override
  Widget build(BuildContext context) {
    final canvasSize =
        MediaQuery.of(context).size.width - 2 * horizontalPadding;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Digit predictor'),
        actions: [
          ToggleThemeButton(
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          ),
        ],
      ),
      body: BlocBuilder<CanvasBloc, CanvasState>(
        builder: (context, state) {
          return ScreenPadding(
            child: Padding(
              padding: const EdgeInsets.all(horizontalPadding),
              child: Column(
                children: [
                  DrawingArea(
                    width: canvasSize,
                    height: canvasSize,
                    onPanStart: (details) => onPanStart(details, context),
                    onPanUpdate: (details) => onPanUpdate(details, context),
                    onPanEnd: (details) => onPanEnd(details, context),
                    currentlyDrawnLine: state.currentlyDrawnLine,
                    allDrawnLines: state.allDrawnLines,
                    strokeColor:
                        Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                    strokeWidth: strokeWidth,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CanvasButtons(
                      onClearPressed: () =>
                          context.read<CanvasBloc>().add(const CanvasCleared()),
                      onCheckPressed: () => context.read<CanvasBloc>().add(
                            CanvasDrawingChecked(
                              canvasSize: canvasSize,
                              strokeWidth: strokeWidth,
                            ),
                          ),
                    ),
                  ),
                  Expanded(
                    child: PredictionDetailsSummary(
                      predictionDetails: state.digitPredictionDetails,
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
