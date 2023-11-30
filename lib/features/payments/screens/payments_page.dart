import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/payments/screens/reconcile_page.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/widgets/asset_icon.dart';
import 'package:ojembaa_courier/utils/widgets/circle.dart';
import 'package:ojembaa_courier/utils/widgets/white_pill.dart';

class PaymentsPage extends ConsumerWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: context.height(.3),
                child: ColoredBox(
                  color: AppColors.primary,
                  child: Column(
                    children: [
                      SizedBox(height: context.width(.2)),
                      Text(
                        "Outstanding Balance",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: context.width(.042),
                          fontWeight: FontWeight.w700,
                          color: AppColors.accent,
                        ),
                      ),
                      SizedBox(height: context.width(.04)),
                      Text(
                        "-₦11,400",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: context.width(.13),
                          fontWeight: FontWeight.w700,
                          fontFamilyFallback: const ["Work Sans"],
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: ColoredBox(
                    color: AppColors.white,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: context.width(.06)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: context.width(.17)),
                          Text(
                            "Reconciliation history",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: context.width(.045),
                              color: AppColors.accent,
                            ),
                          ),
                          SizedBox(height: context.width(.04)),
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: 10,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => WhitePill(
                                  borderRadius: 10,
                                  padding: EdgeInsets.symmetric(
                                      vertical: context.width(.04),
                                      horizontal: context.width(.06)),
                                  margin: EdgeInsets.symmetric(
                                      vertical: context.width(.02)),
                                  color: const Color(0xffE2E2E2),
                                  child: Row(
                                    children: [
                                      Text(
                                        "12/08/2023",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: context.width(.045),
                                          color: AppColors.accent,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "- ₦4,000",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: context.width(.045),
                                          fontFamilyFallback: const [
                                            "Work Sans"
                                          ],
                                          color: AppColors.green,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: context.height(.265),
            left: context.width(.2),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReconcilePage(),
                    ));
              },
              child: WhitePill(
                height: context.height(.07),
                width: context.width(.6),
                borderRadius: 10,
                color: AppColors.accent,
                child: Row(
                  children: [
                    Circle(
                        color: Colors.transparent,
                        borderColor: AppColors.white,
                        width: context.width(.1),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: AssetIcon(icon: "card"),
                        )),
                    Text(
                      "    Click to reconcile",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: context.width(.045),
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
