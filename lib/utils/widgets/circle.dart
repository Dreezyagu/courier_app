import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final double width;
  final Widget child;
  final Color? color, borderColor;

  const Circle(
      {super.key,
      required this.width,
      this.color,
      required this.child,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width,
      width: width,
      decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? Colors.transparent),
          shape: BoxShape.circle,
          color: color ?? const Color(0xffEBC988)),
      child: child,
    );
  }
}
