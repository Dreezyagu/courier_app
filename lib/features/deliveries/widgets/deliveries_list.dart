import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/homepage/providers/get_location_provider.dart';
import 'package:ojembaa_courier/features/homepage/providers/get_requests_provider.dart';
import 'package:ojembaa_courier/features/homepage/screens/delivery_details.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/utitlity.dart';
import 'package:ojembaa_courier/utils/widgets/asset_icon.dart';
import 'package:ojembaa_courier/utils/widgets/circle.dart';
import 'package:ojembaa_courier/utils/widgets/white_pill.dart';

class DeliveriesList extends ConsumerWidget {
  const DeliveriesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController firstController = ScrollController();
    double? distance;

    return Consumer(builder: (context, ref, child) {
      final data = ref.watch(getRequestsProvider).data;

      if (ref.watch(getRequestsProvider).isLoading) {
        return Column(
          children: [
            SizedBox(height: context.width(.4)),
            const CircularProgressIndicator(),
          ],
        );
      }

      if (data == null || data.isEmpty) {
        return Center(
          child: Column(
            children: [
              SizedBox(height: context.width(.35)),
              Text(
                "Waiting for courier request...",
                style: TextStyle(fontSize: context.width(.04)),
              ),
            ],
          ),
        );
      }

      return Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Delivery Request",
                style: TextStyle(
                  fontSize: context.width(.045),
                ),
              ),
              Scrollbar(
                controller: firstController,
                thumbVisibility: true,
                child: ListView.builder(
                  itemCount: data.length,
                  controller: firstController,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final delivery = data[index];

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeliveryDetails(
                                  delivery: delivery, distance: distance),
                            ));
                      },
                      child: WhitePill(
                          borderRadius: 20,
                          margin: EdgeInsets.symmetric(
                              vertical: context.width(.02)),
                          padding: EdgeInsets.symmetric(
                              horizontal: context.width(.06),
                              vertical: context.width(.03)),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      delivery.package?.description ?? "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: context.width(.048)),
                                    ),
                                  ),
                                  Text(
                                    Utility.dateConvertedNoDay(
                                        DateTime.parse(delivery.createdAt!),
                                        format: 'dd MMM yyyy, hh:mm a'),
                                    style: TextStyle(
                                        fontSize: context.width(.033)),
                                  ),
                                ],
                              ),
                              SizedBox(height: context.width(.03)),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Circle(
                                          width: context.width(.05),
                                          color: const Color(0xffFEE5B4),
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.5),
                                            child: AssetIcon(
                                                icon:
                                                    "${delivery.package?.weight?.toLowerCase()}_delivery"),
                                          )),
                                      Text(
                                        "  ${delivery.package?.weight?.toLowerCase().capitalize()} delivery",
                                        style: TextStyle(
                                            fontSize: context.width(.03)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: context.width(.02)),
                                  Row(
                                    children: [
                                      Circle(
                                          width: context.width(.05),
                                          color: AppColors.primary,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.5),
                                            child: AssetIcon(
                                                icon:
                                                    "${delivery.deliveryMode}_delivery"),
                                          )),
                                      Text(
                                        "  ${delivery.deliveryMode?.capitalize()} Delivery",
                                        style: TextStyle(
                                            fontSize: context.width(.03)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              if (delivery.status?.toLowerCase().trim() ==
                                  "scheduled")
                                Consumer(builder: (context, ref, child) {
                                  final data =
                                      ref.watch(getLocationProvider).data;

                                  if (data != null) {
                                    distance = delivery.distance != null
                                        ? double.parse(delivery.distance!)
                                        : Utility.calculateDistance(
                                            data.latitude,
                                            data.longitude,
                                            double.parse(delivery.pickupLat!),
                                            double.parse(delivery.pickupLog!));
                                    return Align(
                                      alignment: Alignment.centerRight,
                                      child: Column(
                                        children: [
                                          SizedBox(height: context.width(.03)),
                                          Text(
                                            "${distance}KM Away".commalise(),
                                            style: TextStyle(
                                                color: AppColors.accent,
                                                fontWeight: FontWeight.w700,
                                                fontSize: context.width(.04)),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                }),
                              if (delivery.status?.toLowerCase().trim() !=
                                  "scheduled")
                                Column(
                                  children: [
                                    SizedBox(height: context.width(.03)),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: WhitePill(
                                        color: AppColors.accent,
                                        margin: EdgeInsets.zero,
                                        borderRadius: 10,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: context.width(.03),
                                            vertical: context.width(.015)),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Circle(
                                                color: delivery.status
                                                            ?.trim() ==
                                                        "ENROUTE_PICKUP"
                                                    ? AppColors.white
                                                    : delivery.status ==
                                                                "DELIVERED" ||
                                                            delivery.status ==
                                                                "COMPLETED"
                                                        ? AppColors.green
                                                        : delivery.status ==
                                                                "IN_PROGRESS"
                                                            ? AppColors.primary
                                                            : AppColors.red,
                                                width: context.width(.015),
                                                child: const SizedBox.shrink()),
                                            Text(
                                              "  ${delivery.status?.replaceFirst("_", " ").toLowerCase().capitalizeAllWord()}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.white,
                                                  fontSize:
                                                      context.width(.033)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          )),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
