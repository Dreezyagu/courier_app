import 'package:flutter/material.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';

class CustomContinueButton2 extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool isActive;
  final Color bgColor;
  final Color? textColor;
  final double? textSize, topPadding, sidePadding, elevation, innerTopPadding;

  final FontWeight? fontWeight;

  const CustomContinueButton2(
      {Key? key,
      required this.onPressed,
      this.title = 'Continue',
      this.sidePadding,
      this.fontWeight,
      this.topPadding,
      this.textColor,
      this.textSize,
      this.elevation,
      this.bgColor = AppColors.primary,
      this.isActive = true,
      this.innerTopPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: sidePadding ?? context.width(.06),
          vertical: topPadding ?? 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: bgColor,
              elevation: elevation,
              shape: RoundedRectangleBorder(
                  side: isActive ? BorderSide(color: bgColor) : BorderSide.none,
                  borderRadius: BorderRadius.circular(50.0)),
            ),
            onPressed: isActive ? onPressed : null,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: innerTopPadding ?? context.width(.04)),
              child: Text(
                title,
                style: TextStyle(
                    color: textColor ?? AppColors.white,
                    fontFamilyFallback: const ["Work Sans"],
                    fontSize: textSize ?? 18.0,
                    fontWeight: fontWeight ?? FontWeight.w700),
              ),
            )),
      ),
    );
  }
}
