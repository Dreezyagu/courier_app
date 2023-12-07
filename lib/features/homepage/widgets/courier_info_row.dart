import 'package:flutter/material.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/widgets/asset_icon.dart';

class CourierRowInfo extends StatelessWidget {
  const CourierRowInfo({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title, value, icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AssetIcon(
          icon: icon,
          size: context.width(.06),
          color: AppColors.white,
        ),
        SizedBox(height: context.width(.02)),
        Text(
          value,
          style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
              fontSize: context.width(.05)),
        ),
        Text(
          title,
          style: TextStyle(
              color: AppColors.white.withOpacity(.78),
              fontSize: context.width(.033)),
        )
      ],
    );
  }
}
