import 'package:flutter/material.dart';
import 'package:linear_gradient_slider/src/linear_painter.dart';

typedef StringCallback = void Function(String val);

class LinearSlider extends StatefulWidget {
  final StringCallback callback;
  final double totalScale;
  final bool showDefaultImages;
  const LinearSlider({
    super.key,
    required this.callback,
    required this.totalScale,
    this.showDefaultImages = false,
  });

  @override
  State<LinearSlider> createState() => _LinearSliderState();
}

class _LinearSliderState extends State<LinearSlider> {
  var width = 350.0;
  var height = 100.0;
  var _dragPosition = 0.0;
  var _dragPercentage = 0.0;
  var _sliderPercentage = 0;
  Color lineColor = Colors.black;
  @override
  void didChangeDependencies() {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    width = MediaQuery.of(context).size.width * 0.9;
    height = isLandscape
        ? MediaQuery.of(context).size.height * 0.2
        : MediaQuery.of(context).size.height * 0.08;
    super.didChangeDependencies();
    setState(() {});
  }

  void _updateDragPosition(Offset val) {
    var newDragPosition = 0.0;
    if (val.dx <= 0) {
      newDragPosition = 0;
    } else if (val.dx >= width) {
      newDragPosition = width;
    } else {
      newDragPosition = val.dx;
    }
    setState(() {
      _dragPosition = newDragPosition;

      _dragPercentage = _dragPosition / width * widget.totalScale;

      if (_dragPercentage % 1 != 0) {
        _dragPosition = (_dragPercentage.round() * width / widget.totalScale);
      }
      _sliderPercentage = _dragPercentage.round();

      widget.callback(_sliderPercentage.toString());
    });
  }

  void _onDragUpdate(BuildContext context, DragUpdateDetails update) {
    RenderBox box = context.findRenderObject() as RenderBox;
    var offset = box.globalToLocal(update.globalPosition);
    _updateDragPosition(offset);
  }

  void _onDragStart(BuildContext context, DragStartDetails start) {
    RenderBox box = context.findRenderObject() as RenderBox;
    var offset = box.globalToLocal(start.globalPosition);
    _updateDragPosition(offset);
  }

  void _onDragEnd(BuildContext context, DragEndDetails end) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.showDefaultImages)
          SizedBox(
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Opacity(
                  opacity: _sliderPercentage > 0 ? 1 : 0.3,
                  child: Image.asset(
                    'assets/feed_back_scale_1.png',
                    height: height * 0.7,
                  ),
                ),
                Opacity(
                  opacity: _sliderPercentage > 1 ? 1 : 0.3,
                  child: Image.asset(
                    'assets/feed_back_scale_2.png',
                    height: height * 0.7,
                  ),
                ),
                Opacity(
                  opacity: _sliderPercentage > 3 ? 1 : 0.3,
                  child: Image.asset(
                    'assets/feed_back_scale_3.png',
                    height: height * 0.7,
                  ),
                ),
                Opacity(
                  opacity: _sliderPercentage > 4 ? 1 : 0.3,
                  child: Image.asset(
                    'assets/feed_back_scale_4.png',
                    height: height * 0.7,
                  ),
                ),
                Opacity(
                  opacity: _sliderPercentage > 6 ? 1 : 0.3,
                  child: Image.asset(
                    'assets/feed_back_scale_5.png',
                    height: height * 0.7,
                  ),
                ),
                Opacity(
                  opacity: _sliderPercentage > 7 ? 1 : 0.3,
                  child: Image.asset(
                    'assets/feed_back_scale_6.png',
                    height: height * 0.7,
                  ),
                ),
                Opacity(
                  opacity: _sliderPercentage > 9 ? 1 : 0.3,
                  child: Image.asset(
                    'assets/feed_back_scale_7.png',
                    height: height * 0.7,
                  ),
                ),
              ],
            ),
          ),
        GestureDetector(
          child: SizedBox(
            height: height,
            width: width,
            child: CustomPaint(
              painter: LinearPainter(
                  totalScaleValue: widget.totalScale,
                  color: lineColor,
                  dragPercentage: _dragPercentage,
                  sliderPosition: _dragPosition),
            ),
          ),
          onHorizontalDragUpdate: (DragUpdateDetails update) =>
              _onDragUpdate(context, update),
          onHorizontalDragStart: (DragStartDetails start) =>
              _onDragStart(context, start),
          onHorizontalDragEnd: (DragEndDetails end) => _onDragEnd(context, end),
        ),
      ],
    );
  }
}
