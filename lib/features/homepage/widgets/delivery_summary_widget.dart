import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ojembaa_courier/features/homepage/model/delivery_model.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/utitlity.dart';
import 'package:ojembaa_courier/utils/widgets/asset_icon.dart';
import 'package:ojembaa_courier/utils/widgets/circle.dart';
import 'package:ojembaa_courier/utils/widgets/white_pill.dart';
import 'package:shimmer/shimmer.dart';

class DeliverySummaryWidget extends StatelessWidget {
  const DeliverySummaryWidget({
    super.key,
    this.extraWidget = const SizedBox.shrink(),
    required this.delivery,
  });

  final Widget extraWidget;
  final DeliveryModel delivery;

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
                  SizedBox(
                      height: context.width(.15),
                      width: context.width(.15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: delivery.package?.photoUrls?.first ?? "",
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: AppColors.hintColor,
                            highlightColor: AppColors.hintColor,
                            child: const SizedBox.shrink(),
                          ),
                          errorWidget: (context, url, error) => const SizedBox(
                            child: ColoredBox(color: AppColors.hintColor),
                          ),
                          fit: BoxFit.fill,
                        ),
                      )),
                  SizedBox(
                    width: context.width(.04),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          delivery.package?.description ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                              fontSize: context.width(.045)),
                        ),
                        SizedBox(height: context.height(.005)),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: context.width(.04),
                    color: AppColors.white,
                  ),
                  SizedBox(width: context.width(.02)),
                  Expanded(
                    child: Text(
                      "${delivery.pickupAddress}. (${delivery.pickupLandmark})",
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
                  Expanded(
                    child: Text(
                      "${delivery.deliveryAddress}. (${delivery.deliveryLandmark})",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                          fontSize: context.width(.037)),
                    ),
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
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: AssetIcon(
                                  icon:
                                      "${delivery.package?.weight?.toLowerCase()}_delivery"),
                            )),
                        Text(
                          "  ${delivery.package?.weight?.toLowerCase().capitalize()} delivery",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColors.white,
                              fontSize: context.width(.033)),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Utility.launchURL(
                            "https://www.google.com/maps/dir/?api=1&origin=${delivery.pickupLat},${delivery.pickupLog}&destination=${delivery.deliveryLat},${delivery.deliveryLog}");
                      },
                      child: const Text(
                        "View on Google Maps",
                        style: TextStyle(color: AppColors.primary),
                      ))
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
                            delivery.deliveryMode == "express"
                                ? "24hrs"
                                : "1-3 days",
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
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: AssetIcon(
                                      icon:
                                          "${delivery.deliveryMode}_delivery"),
                                )),
                          ),
                          SizedBox(width: context.width(.02)),
                          Text(
                            "${delivery.deliveryMode?.capitalize()} Delivery",
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
                    Utility.currencyConverter(
                        Utility.convertToRealNumber(delivery.totalCost ?? "0")),
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
