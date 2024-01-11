import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/payments/providers/get_transactions_provider.dart';
import 'package:ojembaa_courier/features/payments/screens/reconcile_page.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/utitlity.dart';
import 'package:ojembaa_courier/utils/widgets/asset_icon.dart';
import 'package:ojembaa_courier/utils/widgets/circle.dart';
import 'package:ojembaa_courier/utils/widgets/white_pill.dart';

class PaymentsPage extends ConsumerWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(getTransactionsProvider).data;
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
                        "-${Utility.currencyConverter(double.parse(data?.first.currBalance ?? "0"))}",
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
                            "Transaction history",
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
                                itemCount: data?.length,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final mainData = data![index];
                                  return WhitePill(
                                      borderRadius: 10,
                                      padding: EdgeInsets.symmetric(
                                          vertical: context.width(.03),
                                          horizontal: context.width(.04)),
                                      margin: EdgeInsets.symmetric(
                                          vertical: context.width(.02)),
                                      color: AppColors.white,
                                      boxBorder:
                                          Border.all(color: const Color(0xffE5E7EB)),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                mainData.type
                                                        ?.toLowerCase()
                                                        .capitalize() ??
                                                    "",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: context.width(.04),
                                                  color: AppColors.accent,
                                                ),
                                              ),
                                              Text(
                                                Utility.dateConvertedNoDay(
                                                    Utility.convertStringToDate(
                                                        mainData.createdAt ??
                                                            "")),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: context.width(.033),
                                                  color: const Color(0xff9CA3AF),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Text(
                                            "${mainData.type == "DELIVERY" ? "-" : "+"}${Utility.currencyConverter(double.parse(mainData.amount ?? "0"))}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: context.width(.045),
                                              fontFamilyFallback: const [
                                                "Work Sans"
                                              ],
                                              color: mainData.type == "DELIVERY"
                                                  ? const Color(0xFFDC2626)
                                                  : const Color(0xFF00B35C),
                                            ),
                                          ),
                                        ],
                                      ));
                                }),
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
