import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AssetIcon extends StatelessWidget {
  final String icon;
  final String type;
  final Color? color;
  final double? size;
  final String? semanticLabel;
  final bool hasDot;
  final Color? dotColor;
  final bool overrideSVGColor;

  const AssetIcon({
    Key? key,
    required this.icon,
    this.color,
    this.size,
    this.semanticLabel,
    this.hasDot = false,
    this.dotColor,
    this.overrideSVGColor = true,
    this.type = "svg",
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    IconThemeData iconTheme = IconTheme.of(context);
    double size = this.size ?? iconTheme.size ?? 16.0;
    if (type == "svg") {
      return SvgPicture.asset(
        "assets/icons/$icon.svg",
        height: size,
        width: size,
        colorFilter: color == null
            ? null
            : ColorFilter.mode(
                color!,
                !overrideSVGColor ? BlendMode.dst : BlendMode.srcIn,
              ),
        semanticsLabel: semanticLabel,
      );
    }
    return Image.asset(
      "assets/icons/$icon.png",
      height: size,
      width: size,
      color: color,
    );
  }
}
