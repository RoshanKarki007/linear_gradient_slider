import 'package:flutter/material.dart';

class LinearPainter extends CustomPainter {
  final double sliderPosition;
  final double dragPercentage;
  final Color color;
  final Paint fillPainter;
  final Paint lineFillerPainter;
  final double totalScaleValue;
  LinearPainter(
      {required this.totalScaleValue,
      required this.sliderPosition,
      required this.color,
      required this.dragPercentage})
      : fillPainter = Paint()
          ..color = color
          ..style = PaintingStyle.fill,
        lineFillerPainter = Paint()
          // ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5;

  @override
  void paint(Canvas canvas, Size size) {
    _paintLine(canvas, size);
    _paintForegroundLine(canvas, size);
    _paintBorders(canvas, size);
    _paintContainerBorder(canvas, size);
    _paintNumbers(canvas, size);
  }

  _paintForegroundLine(Canvas canvas, Size size) {
    final foregroundPainter = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt
      ..color = Colors.black.withOpacity(0.5);

    Path path = Path();
    path.moveTo(sliderPosition, size.height / 7);
    path.lineTo(size.width, size.height / 7);
    canvas.drawPath(path, foregroundPainter);
  }

  _paintLine(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 7);

    final backgroundPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt
      ..shader = const LinearGradient(
        colors: [Colors.green, Color(0xFFFEBD38), Colors.red],
      ).createShader(
          Rect.fromCircle(center: center, radius: (size.width - 5) / 2));

    var path = Path();
    path.moveTo(0.0, size.height / 7);
    path.lineTo(size.width, size.height / 7);
    canvas.drawPath(path, backgroundPaint);
  }

  _paintBorders(Canvas canvas, Size size) {
    final borderPainter = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Colors.black;

    var gaps = (size.width / totalScaleValue);
    var newGap = 0.0;
    for (var i = 0; i < totalScaleValue; i++) {
      var sliderRect =
          Offset(newGap, (size.height / 7) - 5) & const Size(3.0, 10.0);
      if (i != 0) canvas.drawRect(sliderRect, borderPainter);
      newGap = newGap + gaps;
    }
  }

  _paintNumbers(Canvas canvas, Size size) {
    const textStyle =
        TextStyle(color: Colors.black, fontWeight: FontWeight.w600);
    var gaps = (size.width / totalScaleValue);
    var newGap = 0.0;
    for (var i = 0; i <= totalScaleValue; i++) {
      final textSpan = TextSpan(
        text: i.toString(),
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );

      final offset = Offset(newGap, (size.height) / 2.3);

      textPainter.paint(canvas, offset);

      if (i == 9) {
        newGap = newGap + gaps * 0.6;
      } else {
        newGap = newGap + gaps;
      }
    }
  }

  _paintContainerBorder(Canvas canvas, Size size) {
    final borderPainter = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..color = Colors.black;

    var sliderRect = Offset(0.0, (size.height / 7) - 5) & Size(size.width, 10);
    canvas.drawRect(sliderRect, borderPainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
