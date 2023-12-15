import 'package:flutter/material.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';

class CustomContinueButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final bool isActive;
  final Color bgColor;
  final Color? textColor, disabledBgColor;
  final Color? borderColor;
  final double? textSize;
  final double? topPadding;
  final double? innerTopPadding;
  final bool enabled;
  final double? sidePadding;
  final double? elevation;
  final FontWeight? fontWeight;

  const CustomContinueButton(
      {Key? key,
      required this.onPressed,
      this.fontWeight,
      this.title = 'Continue',
      this.sidePadding,
      this.topPadding,
      this.textColor,
      this.borderColor,
      this.textSize,
      this.elevation,
      this.bgColor = AppColors.primary,
      this.isActive = true,
      this.enabled = true,
      this.innerTopPadding,
      this.disabledBgColor})
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
            disabledBackgroundColor:
                disabledBgColor ?? AppColors.white_background,
            shape: RoundedRectangleBorder(
                side: enabled
                    ? isActive
                        ? BorderSide(color: borderColor ?? bgColor)
                        : BorderSide.none
                    : BorderSide.none,
                borderRadius: BorderRadius.circular(50.0)),
          ),
          onPressed: enabled
              ? isActive
                  ? onPressed
                  : null
              : null,
          child: isActive
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: context.height(.02)),
                  child: Text(
                    title,
                    style: TextStyle(
                        color: textColor ?? AppColors.white,
                        fontFamilyFallback: const ["Work Sans"],
                        fontSize: textSize ?? 18.0,
                        fontWeight: fontWeight ?? FontWeight.w700),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * .025),
                  child: const ButtonCircularLoadingIndicator(),
                ),
        ),
      ),
    );
  }
}

// class CustomContinueButton2 extends StatelessWidget {
//   final VoidCallback onPressed;
//   final String title;
//   final bool isActive;
//   final Color bgColor;
//   final Color? textColor;
//   final double? textSize;
//   final double? topPadding;
//   final double? sidePadding;
//   final double? elevation;
//   final FontWeight? fontWeight;

//   const CustomContinueButton2(
//       {Key? key,
//       required this.onPressed,
//       this.title = 'Continue',
//       this.sidePadding,
//       this.fontWeight,
//       this.topPadding,
//       this.textColor,
//       this.textSize,
//       this.elevation,
//       this.bgColor = AppColors.primary,
//       this.isActive = true})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           horizontal: sidePadding ?? context.width(.06),
//           vertical: topPadding ?? 16),
//       child: SizedBox(
//         width: double.infinity,
//         child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: bgColor,
//               elevation: elevation,
//               shape: RoundedRectangleBorder(
//                   side: isActive ? BorderSide(color: bgColor) : BorderSide.none,
//                   borderRadius: BorderRadius.circular(50.0)),
//             ),
//             onPressed: isActive ? onPressed : null,
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: context.height(.02)),
//               child: Text(
//                 title,
//                 style: TextStyle(
//                     color: textColor ?? AppColors.white,
//                     fontFamilyFallback: const ["Work Sans"],
//                     fontSize: textSize ?? 18.0,
//                     fontWeight: fontWeight ?? FontWeight.w700),
//               ),
//             )),
//       ),
//     );
//   }
// }

class ButtonCircularLoadingIndicator extends StatelessWidget {
  const ButtonCircularLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: AppColors.primary)),
      child: const SizedBox(
        width: 10.0,
        height: 10.0,
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      ),
    );
  }
}
