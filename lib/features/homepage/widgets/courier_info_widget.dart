import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/authentication/providers/user_provider.dart';
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
    return Consumer(builder: (context, ref, child) {
      final data = ref.watch(userProvider).data;
      return Container(
        padding: EdgeInsets.all(context.width(.04)),
        decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
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
                  "   ${data?.firstName} ${data?.lastName}",
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CourierRowInfo(
                      icon: "star",
                      value: double.parse("${data?.rating ?? 5}").toString(),
                      title: "Rating",
                    ),
                    const CourierRowInfo(
                      icon: "speedometer",
                      value: "0KM",
                      title: "Est. distance covered",
                    ),
                    CourierRowInfo(
                      icon: "medium_delivery",
                      value: "${data?.deliveries ?? 0}",
                      title: "Deliveries",
                    ),
                  ],
                ))
          ],
        ),
      );
    });
  }
}
