import 'package:flutter/material.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';
import 'package:ojembaa_courier/utils/widgets/asset_icon.dart';
import 'package:ojembaa_courier/utils/widgets/circle.dart';
import 'package:ojembaa_courier/utils/widgets/white_pill.dart';

class DeliverySummaryWidget extends StatelessWidget {
  const DeliverySummaryWidget({
    super.key,
    this.extraWidget = const SizedBox.shrink(),
  });

  final Widget extraWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
              horizontal: context.width(.04), vertical: context.height(.02)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.accent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    ImageUtil.test_image,
                    height: context.height(.08),
                  ),
                  SizedBox(
                    width: context.width(.04),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Electronic Wall Clock",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                              fontSize: context.width(.045)),
                        ),
                        SizedBox(height: context.height(.005)),
                        Text(
                          "Tracking #ID: 0208322773",
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: context.width(.035)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: context.width(.07),
                child: Divider(
                  color: AppColors.primary.withOpacity(.6),
                ),
              ),
              Text(
                "Pick up",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.white.withOpacity(.69),
                    fontSize: context.width(.037)),
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: context.width(.04),
                    color: AppColors.white,
                  ),
                  SizedBox(width: context.width(.02)),
                  Expanded(
                    child: Text(
                      "Wuse 2, opp. Atiku house, Abuja.",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                          fontSize: context.width(.037)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.width(.07)),
              Text(
                "Drop off",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.white.withOpacity(.69),
                    fontSize: context.width(.037)),
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: context.width(.04),
                    color: AppColors.white,
                  ),
                  SizedBox(width: context.width(.02)),
                  Text(
                    "Maitama NNPC quarters, Abuja. ",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                        fontSize: context.width(.037)),
                  ),
                ],
              ),
              SizedBox(
                height: context.width(.07),
                child: Divider(
                  color: AppColors.primary.withOpacity(.6),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Circle(
                            width: context.width(.065),
                            color: const Color(0xffE2CEA2),
                            child: const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: AssetIcon(icon: "bike"),
                            )),
                        Text(
                          "  Light delivery",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColors.white,
                              fontSize: context.width(.033)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "10.3kg",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                          fontSize: context.width(.033)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        WhitePill(
          width: double.infinity,
          borderRadius: 20,
          padding: EdgeInsets.all(context.width(.04)),
          margin: EdgeInsets.symmetric(vertical: context.width(.05)),
          color: const Color(0xffFEE4B1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: context.height(.004)),
                        child: AssetIcon(
                          icon: "eta",
                          size: context.width(.05),
                        ),
                      ),
                      SizedBox(width: context.width(.02)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ETA",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: context.width(.035)),
                          ),
                          Text(
                            "1-3 days",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: AppColors.accent,
                                fontSize: context.width(.035)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: context.height(.004)),
                            child: Circle(
                                width: context.width(.05),
                                color: AppColors.primary,
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: AssetIcon(icon: "express_delivery"),
                                )),
                          ),
                          SizedBox(width: context.width(.02)),
                          Text(
                            "Express Delivery",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: context.width(.033)),
                          ),
                        ],
                      ),
                      SizedBox(height: context.width(.01)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AssetIcon(
                            icon: "pay_cash",
                            size: context.width(.04),
                          ),
                          SizedBox(width: context.width(.02)),
                          Text(
                            "Pay on delivery",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: context.width(.033)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: context.width(.06)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivery fee",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: context.width(.033)),
                  ),
                  Text(
                    "₦15,000",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.red,
                        fontSize: context.width(.05)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
