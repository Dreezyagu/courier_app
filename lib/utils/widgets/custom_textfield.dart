import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      required this.controller,
      this.label,
      this.hintText,
      this.onChange,
      this.initialValue,
      this.validator,
      this.obscureText = false,
      this.onTap,
      this.obscuringCharacter = '•',
      this.suffix,
      this.prefix,
      this.autovalidateMode,
      this.autoDisposeController = true,
      this.keyboardType,
      this.readOnly = false,
      this.expands = false,
      this.maxLines = 1,
      this.onSaved,
      this.minLines,
      this.maxLength,
      this.autofillHints,
      this.inputFormatters,
      this.enabled,
      this.borderColor,
      this.fillColor,
      this.counterText,
      this.padding,
      this.textCapitalization = TextCapitalization.none,
      this.style,
      this.margin,
      this.labelWeight,
      this.labelSize,
      this.labelColor})
      : super(key: key);

  final String? label;
  final String? hintText;
  final ValueChanged<String>? onChange;
  final String? initialValue;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  final VoidCallback? onTap;
  final bool obscureText;
  final String obscuringCharacter;
  final Widget? suffix;
  final Widget? prefix;
  final AutovalidateMode? autovalidateMode;
  final bool autoDisposeController;
  final TextInputType? keyboardType;
  final bool readOnly;
  final bool expands;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final List<String>? autofillHints;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? borderColor;
  final Color? fillColor;
  final bool? enabled;
  final String? counterText;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final Color? labelColor;
  final FontWeight? labelWeight;
  final double? labelSize;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null)
          Column(
            children: [
              Text(
                label ?? '',
                style: TextStyle(
                  color: labelColor ?? AppColors.black,
                  fontSize: labelSize ?? context.width(.038),
                  fontFamilyFallback: const ["Work Sans"],
                  fontWeight: labelWeight ?? FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        Padding(
          padding: margin ?? EdgeInsets.zero,
          child: TextFormField(
            controller: controller,
            validator: (value) {
              return validator?.call(value);
            },
            obscureText: obscureText,
            obscuringCharacter: obscuringCharacter,
            autovalidateMode: autovalidateMode,
            keyboardType: keyboardType,
            onChanged: onChange,
            readOnly: readOnly,
            onSaved: onSaved,
            onTap: onTap,
            textCapitalization: textCapitalization,
            expands: expands,
            enabled: enabled,
            inputFormatters: inputFormatters,
            minLines: expands ? null : minLines,
            maxLines: expands ? null : maxLines,
            maxLength: maxLength,
            autofillHints: autofillHints,
            style: style,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: AppColors.hintColor,
              ),
              fillColor: fillColor ?? AppColors.white,
              filled: true,
              suffixIcon: suffix,
              counterText: counterText,
              prefixIcon: prefix,
              isDense: true,
              errorStyle: const TextStyle(fontFamilyFallback: ["Work Sans"]),
              contentPadding: padding ??
                  EdgeInsets.symmetric(
                    horizontal: context.width(.06),
                    vertical: context.width(.045),
                  ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                      color: borderColor ?? Colors.black38, width: .5)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                      color: borderColor ?? Colors.black38, width: .5)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                      width: .5, color: borderColor ?? Colors.black38)),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          ),
        ),
      ],
    );
  }
}
