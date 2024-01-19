import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';
import 'package:ojembaa_courier/utils/widgets/custom_button.dart';

class ReconciliationSuccess extends StatelessWidget {
  const ReconciliationSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white_background,
      body: PopScope(
        canPop: false,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: context.height(.3)),
              SvgPicture.asset(ImageUtil.delivery_confirmed),
              SizedBox(height: context.height(.02)),
              Text(
                "Your reconcile request has been sent for confirmation",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: context.width(.06)),
              ),
              SizedBox(height: context.height(.02)),
              Text(
                "Within the next 24 hours your\nreconciliation will be confirmed",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w400,
                    fontSize: context.width(.045)),
              ),
              const Spacer(),
              Consumer(builder: (context, ref, child) {
                return CustomContinueButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  title: "Back to home",
                );
              }),
              SizedBox(height: context.height(.05))
            ],
          ),
        ),
      ),
    );
  }
}
