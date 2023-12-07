import 'package:flutter/material.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinTextField extends StatelessWidget {
  final TextEditingController? controller;
  final int length;

  const PinTextField({Key? key, required this.controller, this.length = 4})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
        child: PinCodeTextField(
          appContext: context,
          length: length,
          animationType: AnimationType.fade,
          obscureText: true,
          obscuringWidget: Container(
            height: 10,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accent,
            ),
          ),
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          controller: controller,
          backgroundColor: Colors.transparent,
          enableActiveFill: true,
          enablePinAutofill: false,
          keyboardType: TextInputType.number,
          keyboardAppearance: Theme.of(context).brightness,
          autoDisposeControllers: false,
          showCursor: false,
          textStyle: const TextStyle(color: Colors.white),
          pinTheme: PinTheme(
              activeColor: AppColors.primary,
              activeFillColor: AppColors.accent.withOpacity(.16),
              inactiveColor: AppColors.accent.withOpacity(.16),
              inactiveFillColor: AppColors.accent.withOpacity(.16),
              selectedFillColor: AppColors.accent.withOpacity(.16),
              selectedColor: AppColors.accent.withOpacity(.16),
              fieldHeight: context.width(.13),
              fieldWidth: context.width(.13),
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(10)),
          onChanged: (_) {},
        ));
  }
}
