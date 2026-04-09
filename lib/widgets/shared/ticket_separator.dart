import 'package:flutter/material.dart';

class TicketSeparator extends StatelessWidget {
  final double height;
  final Color color;
  final double punchedRadius;

  const TicketSeparator({
    super.key,
    this.height = 1.0,
    this.color = const Color(0xFFF3F4F6), // Greyish line
    this.punchedRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: punchedRadius / 2),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Dashed line
          SizedBox(
            height: height,
            width: double.infinity,
            child: CustomPaint(
              painter: DashedLinePainter(color: color, strokeWidth: height, dashWidth: 5, gap: 3),
            ),
          ),
          
          // Punched out circles on the edges
          Positioned(
            left: -punchedRadius / 2,
            child: Container(
              width: punchedRadius,
              height: punchedRadius,
              decoration: const BoxDecoration(
                color: Color(0xFFFAFAFF), // Matches screen tint background
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: -punchedRadius / 2,
            child: Container(
              width: punchedRadius,
              height: punchedRadius,
              decoration: const BoxDecoration(
                color: Color(0xFFFAFAFF), // Matches screen tint background
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double gap;

  DashedLinePainter({required this.color, required this.strokeWidth, required this.dashWidth, required this.gap});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Path path = Path();
    double currentX = 0;
    while (currentX < size.width) {
      path.moveTo(currentX, 0);
      path.lineTo(currentX + dashWidth, 0);
      currentX += dashWidth + gap;
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}