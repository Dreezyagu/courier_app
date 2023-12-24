// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ojembaa_courier/features/authentication/providers/user_provider.dart';
import 'package:ojembaa_courier/features/homepage/providers/get_location_provider.dart';
import 'package:ojembaa_courier/features/homepage/providers/online_status_provider.dart';
import 'package:ojembaa_courier/features/homepage/screens/delivery_details.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';
import 'package:ojembaa_courier/utils/widgets/asset_icon.dart';
import 'package:ojembaa_courier/utils/widgets/circle.dart';
import 'package:ojembaa_courier/utils/widgets/snackbar.dart';
import 'package:ojembaa_courier/utils/widgets/white_pill.dart';

class HomepageDeliveriesWidget extends ConsumerStatefulWidget {
  const HomepageDeliveriesWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HomepageDeliveriesWidgetState();
}

class _HomepageDeliveriesWidgetState
    extends ConsumerState<HomepageDeliveriesWidget> {
  bool isOnline = false;
  final ScrollController _firstController = ScrollController();
  LocationPermission? permission;
  @override
  void initState() {
    requestPermission();
    super.initState();
  }

  requestPermission() async {
    permission = await Geolocator.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.width(.06), vertical: context.width(.05)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AssetIcon(
                icon: "menu",
                size: context.width(.04),
              ),
              Consumer(builder: (context, ref, child) {
                final userData = ref.watch(userProvider).data;
                final locationData = ref.watch(getLocationProvider).data;
                final reader = ref.read(onlineStatusProvider.notifier);
                return GestureDetector(
                  onTap: () async {
                    if (!await Geolocator.isLocationServiceEnabled()) {
                      CustomSnackbar.showErrorSnackBar(context,
                          message: "Please enable location permissions");
                      permission = await Geolocator.requestPermission();
                    }
                    setState(() {
                      isOnline = !isOnline;
                    });
                    reader.onlineStatus(
                      id: userData!.id!,
                      status: isOnline,
                      onError: (p0) {
                        CustomSnackbar.showErrorSnackBar(context, message: p0);
                        setState(() {
                          isOnline = !isOnline;
                        });
                      },
                      onSuccess: () {
                        if (locationData != null) {
                          reader.updateLocation(
                            id: userData.id!,
                            payload: {
                              "lng": locationData.longitude,
                              "lat": locationData.latitude
                            },
                            onError: (p0) {
                              CustomSnackbar.showErrorSnackBar(context,
                                  message: p0);
                            },
                          );
                        }
                      },
                    );
                  },
                  child: WhitePill(
                      borderRadius: 20,
                      padding: EdgeInsets.all(context.width(.01)),
                      color: AppColors.accent,
                      child: AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 200,
                        ),
                        margin: isOnline
                            ? EdgeInsets.only(left: context.width(.1))
                            : EdgeInsets.only(right: context.width(.1)),
                        padding: EdgeInsets.symmetric(
                            horizontal: context.width(.03),
                            vertical: context.width(.02)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: isOnline
                                ? const Color(0xff515F59)
                                : AppColors.primary),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isOnline)
                              AssetIcon(
                                icon: "arrow_backward",
                                size: context.width(.03),
                              ),
                            Text(
                              isOnline ? "  Go Offline" : " Go Online  ",
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: context.width(.038)),
                            ),
                            if (!isOnline)
                              AssetIcon(
                                icon: "arrow_forward",
                                size: context.width(.03),
                              )
                          ],
                        ),
                      )),
                );
              }),
            ],
          ),
          SizedBox(height: context.width(.05)),
          if (!isOnline)
            Column(
              children: [
                SizedBox(height: context.width(.08)),
                SvgPicture.asset(
                  ImageUtil.courier_offline,
                  height: context.width(.6),
                ),
                Text(
                  "Offline",
                  style: TextStyle(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w700,
                      fontSize: context.width(.047)),
                ),
                SizedBox(height: context.width(.02)),
                Text(
                  "You are currently offline,\nturn back online, to get delivery orders",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.black, fontSize: context.width(.04)),
                ),
              ],
            ),
          if (isOnline)
            // Column(
            //   children: [
            //     SizedBox(height: context.width(.35)),
            //     Text(
            //       "Waiting for courier request...",
            //       style: TextStyle(
            //     fontSize: context.width(.04)),
            //     ),
            //   ],
            // )
            Expanded(
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
                      controller: _firstController,
                      thumbVisibility: true,
                      child: ListView.builder(
                        itemCount: 5,
                        controller: _firstController,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const DeliveryDetails(),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Electronic Wall Clock",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: context.width(.048)),
                                          ),
                                        ),
                                        Text(
                                          "10:45AM",
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
                                                color: AppColors.primary,
                                                child: const Padding(
                                                  padding: EdgeInsets.all(3.5),
                                                  child: AssetIcon(
                                                      icon: "express_delivery"),
                                                )),
                                            Text(
                                              "  Light delivery",
                                              style: TextStyle(
                                                  fontSize:
                                                      context.width(.027)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: context.width(.02)),
                                        Row(
                                          children: [
                                            Circle(
                                                width: context.width(.05),
                                                color: AppColors.primary,
                                                child: const Padding(
                                                  padding: EdgeInsets.all(3.5),
                                                  child: AssetIcon(
                                                      icon: "express_delivery"),
                                                )),
                                            Text(
                                              "  Express Delivery",
                                              style: TextStyle(
                                                  fontSize:
                                                      context.width(.027)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "3KM Away",
                                        style: TextStyle(
                                            color: AppColors.accent,
                                            fontWeight: FontWeight.w700,
                                            fontSize: context.width(.04)),
                                      ),
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
            )
        ],
      ),
    ));
  }
}
