
import 'package:flutter/material.dart';
import 'package:ojembaa_courier/features/homepage/widgets/courier_info_row.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/widgets/asset_icon.dart';
import 'package:ojembaa_courier/utils/widgets/white_pill.dart';

class CourierInfoWidget extends StatelessWidget {
  const CourierInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.width(.04)),
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20))),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: context.width(.05),
                child: const AssetIcon(
                  icon: "profile",
                  size: double.infinity,
                ),
              ),
              Text(
                "   Wole Mafekodunmi",
                style: TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w700,
                    fontSize: context.width(.047)),
              )
            ],
          ),
          SizedBox(height: context.width(.05)),
          WhitePill(
              borderRadius: 15,
              padding: EdgeInsets.all(context.width(.06)),
              color: AppColors.primary,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CourierRowInfo(
                    icon: "star",
                    value: "4.5",
                    title: "Rating",
                  ),
                  CourierRowInfo(
                    icon: "speedometer",
                    value: "68.7KM",
                    title: "Est. distance covered",
                  ),
                  CourierRowInfo(
                    icon: "car",
                    value: "37",
                    title: "Deliveries",
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
