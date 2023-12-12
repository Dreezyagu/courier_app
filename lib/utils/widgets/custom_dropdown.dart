// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';

class CustomDropDownFormField<T> extends StatefulWidget {
  const CustomDropDownFormField(
      {Key? key,
      this.hintText,
      this.padding,
      required this.items,
      required this.value,
      required this.onChanged,
      this.validator,
      this.hintFontSize,
      this.labelColor,
      this.borderColor,
      this.fontSize,
      this.fillColor,
      this.height,
      this.isExpanded = false})
      : super(key: key);

  final String? hintText;
  final EdgeInsetsGeometry? padding;
  final Color? labelColor;
  final Color? fillColor;
  final bool isExpanded;
  final Color? borderColor;

  final String? Function(T?)? validator;

  final List<DropdownMenuItem<T>>? items;
  final T? value;
  final ValueChanged<T>? onChanged;
  final double? height;
  final double? hintFontSize;
  final double? fontSize;

  @override
  _CustomDropDownFormFieldState<T> createState() =>
      _CustomDropDownFormFieldState<T>();
}

class _CustomDropDownFormFieldState<T>
    extends State<CustomDropDownFormField<T?>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: widget.height,
          child: DropdownButtonFormField<T?>(
            style: TextStyle(
              color: AppColors.black,
              fontSize: widget.fontSize ?? context.width(.037),
            ),
            value: widget.value,
            icon: const Icon(Icons.keyboard_arrow_down),
            isExpanded: widget.isExpanded,
            dropdownColor: AppColors.white,
            hint: Text(widget.hintText ?? '',
                style: TextStyle(
                    fontFamily: "QanelasSoft",
                    fontSize: widget.hintFontSize,
                    color: AppColors.hintColor)),
            validator: widget.validator,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.white,
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                      color: widget.borderColor ?? AppColors.white, width: 2)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                      color: widget.borderColor ?? AppColors.white, width: .5)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                      color: widget.borderColor ?? AppColors.white, width: .5)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 1.5)),
              isDense: true,
              labelText: null,
              contentPadding: widget.padding ??
                  EdgeInsets.symmetric(
                    horizontal: context.width(.06),
                    vertical: context.width(.045),
                  ),
            ),
            items: widget.items,
            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }
}
