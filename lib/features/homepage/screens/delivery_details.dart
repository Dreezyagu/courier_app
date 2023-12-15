import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/homepage/widgets/decline_dialog.dart';
import 'package:ojembaa_courier/features/homepage/widgets/delivery_summary_widget.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';
import 'package:ojembaa_courier/utils/widgets/circle.dart';
import 'package:ojembaa_courier/utils/widgets/custom_appbar.dart';
import 'package:ojembaa_courier/utils/widgets/custom_button.dart';
import 'package:ojembaa_courier/utils/widgets/white_pill.dart';

class DeliveryDetails extends ConsumerStatefulWidget {
  const DeliveryDetails({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DeliveryDetailsState();
}

class _DeliveryDetailsState extends ConsumerState<DeliveryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        bgColor: AppColors.primary_light,
        title: Text(
          "Details",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(context.width(.05)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "3km Away",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.accent,
                  fontSize: context.width(.05)),
            ),
            SizedBox(height: context.width(.04)),
            const DeliverySummaryWidget(),
            Row(
              children: [
                Expanded(
                    child: CustomContinueButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const DeclineDialog(),
                    );
                  },
                  sidePadding: 10,
                  title: "Decline",
                  elevation: 0,
                  innerTopPadding: context.width(.035),
                  bgColor: const Color(0xff707070),
                )),
                Expanded(
                    child: CustomContinueButton(
                  onPressed: () {},
                  elevation: 0,
                  innerTopPadding: context.width(.035),
                  sidePadding: 10,
                  title: "Accept",
                ))
              ],
            ),
            WhitePill(
              padding: EdgeInsets.symmetric(vertical: context.width(.025)),
              margin: EdgeInsets.symmetric(vertical: context.width(.017)),
              color: AppColors.accent,
              child: ListTile(
                onTap: () {},
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(ImageUtil.test_image),
                ),
                title: Text(
                  "Ikenna Okwara",
                  style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: context.width(.04)),
                ),
                trailing: Circle(
                    color: Colors.transparent,
                    borderColor: AppColors.primary,
                    width: context.width(.12),
                    child: const Icon(
                      Icons.phone,
                      color: AppColors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
