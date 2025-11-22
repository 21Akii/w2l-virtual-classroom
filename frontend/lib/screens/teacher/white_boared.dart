import 'package:flutter/material.dart';

class Whiteboard extends StatefulWidget {
  const Whiteboard({super.key});

  @override
  State<Whiteboard> createState() => _WhiteboardState();
}

class _WhiteboardState extends State<Whiteboard> {
  List<Offset?> points = [];
  Color currentColor = Colors.white;
  double strokeWidth = 4.0;
  bool eraseMode = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // DRAWING AREA
        GestureDetector(
          onPanUpdate: (details) {
            RenderBox? renderBox = context.findRenderObject() as RenderBox?;
            Offset point = renderBox!.globalToLocal(details.globalPosition);

            setState(() {
              points.add(point);
            });
          },
          onPanEnd: (details) {
            setState(() {
              points.add(null); // separate strokes
            });
          },
          child: CustomPaint(
            size: Size.infinite,
            painter: _WhiteboardPainter(points, currentColor, strokeWidth, eraseMode),
          ),
        ),

        // TOOLS
        Positioned(
          top: 10,
          right: 10,
          child: Column(
            children: [
              FloatingActionButton(
                mini: true,
                backgroundColor: eraseMode ? Colors.red : Colors.white,
                onPressed: () {
                  setState(() {
                    eraseMode = !eraseMode;
                  });
                },
                child: Icon(
                  Icons.cleaning_services,
                  color: eraseMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                mini: true,
                backgroundColor: Colors.white,
                onPressed: () {
                  setState(() {
                    points.clear();
                  });
                },
                child: const Icon(Icons.delete, color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ------------------- PAINTER --------------------

class _WhiteboardPainter extends CustomPainter {
  final List<Offset?> points;
  final Color color;
  final double strokeWidth;
  final bool eraseMode;

  _WhiteboardPainter(this.points, this.color, this.strokeWidth, this.eraseMode);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = eraseMode ? Colors.transparent : color
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..blendMode = eraseMode ? BlendMode.clear : BlendMode.srcOver;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
