import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/homepage/model/delivery_model.dart';
import 'package:ojembaa_courier/features/homepage/providers/accept_delivery_provider.dart';
import 'package:ojembaa_courier/features/homepage/providers/get_requests_provider.dart';
import 'package:ojembaa_courier/features/homepage/providers/get_single_request_provider.dart';
import 'package:ojembaa_courier/features/homepage/widgets/decline_dialog.dart';
import 'package:ojembaa_courier/features/homepage/widgets/delivery_summary_widget.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';
import 'package:ojembaa_courier/utils/components/utitlity.dart';
import 'package:ojembaa_courier/utils/widgets/circle.dart';
import 'package:ojembaa_courier/utils/widgets/custom_appbar.dart';
import 'package:ojembaa_courier/utils/widgets/custom_button.dart';
import 'package:ojembaa_courier/utils/widgets/custom_dropdown.dart';
import 'package:ojembaa_courier/utils/widgets/snackbar.dart';
import 'package:ojembaa_courier/utils/widgets/white_pill.dart';

class DeliveryDetails extends ConsumerStatefulWidget {
  final DeliveryModel delivery;
  final double? distance;

  const DeliveryDetails(
      {super.key, required this.delivery, required this.distance});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DeliveryDetailsState();
}

class _DeliveryDetailsState extends ConsumerState<DeliveryDetails> {
  String? deliveryStatus;
  @override
  void initState() {
    deliveryStatus = widget.delivery.status?.trim();
    super.initState();
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(context.width(.05)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.distance != null &&
                  widget.delivery.status?.toLowerCase().trim() == "scheduled")
                Text(
                  "${widget.distance?.round()} km Away".commalise(),
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.accent,
                      fontSize: context.width(.05)),
                ),
              WhitePill(
                  width: double.infinity,
                  borderRadius: 20,
                  padding: EdgeInsets.all(context.width(.04)),
                  margin: EdgeInsets.symmetric(vertical: context.width(.05)),
                  color: const Color(0xffFEE4B1),
                  child: Row(
                    children: [
                      Text(
                        "Delivery Status",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.accent,
                            fontSize: context.width(.04)),
                      ),
                      SizedBox(
                        width: context.width(.04),
                      ),
                      Expanded(
                        child: CustomDropDownFormField<String>(
                            items: ["SCHEDULED", "ENROUTE_PICKUP"]
                                .map((e) => DropdownMenuItem<String>(
                                      value: e,
                                      child: Row(
                                        children: [
                                          Circle(
                                              color: e == "ENROUTE_PICKUP"
                                                  ? AppColors.white
                                                  : e == "DELIVERED"
                                                      ? AppColors.green
                                                      : AppColors.red,
                                              width: context.width(.015),
                                              child: const SizedBox.shrink()),
                                          Text(
                                            "  ${e.replaceFirst("_", " ").toLowerCase().capitalizeAllWord()}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.white,
                                                fontSize: context.width(.037)),
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                            value: deliveryStatus,
                            borderRadius: 10,
                            textColor: AppColors.accent,
                            borderColor: AppColors.accent,
                            fillColor: AppColors.accent,
                            dropdownColor: AppColors.accent,
                            padding: EdgeInsets.symmetric(
                              horizontal: context.width(.03),
                              vertical: context.width(.025),
                            ),
                            onChanged: (String? val) {
                              setState(() {
                                deliveryStatus = val;
                              });
                            }),
                      )
                    ],
                  )),
              SizedBox(height: context.width(.04)),
              DeliverySummaryWidget(delivery: widget.delivery),
              if (widget.delivery.status?.toLowerCase().trim() == "scheduled")
                Row(
                  children: [
                    Expanded(
                        child: CustomContinueButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => DeclineDialog(
                            deliveryId: widget.delivery.id!,
                            onSuccess: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                      sidePadding: 10,
                      title: "Decline",
                      elevation: 0,
                      innerTopPadding: context.width(.035),
                      bgColor: const Color(0xff707070),
                    )),
                    Expanded(child: Consumer(builder: (context, ref, child) {
                      final data1 = ref.watch(acceptDeliveryProvider("accept"));
                      final data2 = ref.watch(getSingleRequestProvider);

                      return CustomContinueButton(
                        onPressed: () {
                          ref
                              .read(acceptDeliveryProvider("accept").notifier)
                              .acceptDelivery(
                                  id: widget.delivery.id!,
                                  status: "accept",
                                  onSuccess: () {
                                    ref
                                        .read(getRequestsProvider.notifier)
                                        .getRequests();
                                    ref
                                        .read(getSingleRequestProvider.notifier)
                                        .getSingleRequest(
                                      widget.delivery.id!,
                                      onSuccess: (delivery) {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DeliveryDetails(
                                                      delivery: delivery,
                                                      distance:
                                                          widget.distance),
                                            ));
                                      },
                                      onError: (p0) {
                                        CustomSnackbar.showErrorSnackBar(
                                            context,
                                            message: p0);
                                      },
                                    );
                                  },
                                  onError: (p0) {});
                        },
                        elevation: 0,
                        innerTopPadding: context.width(.035),
                        sidePadding: 10,
                        isActive: !data1.isLoading && !data2.isLoading,
                        title: "Accept",
                      );
                    }))
                  ],
                ),
              WhitePill(
                padding: EdgeInsets.symmetric(vertical: context.width(.025)),
                margin: EdgeInsets.symmetric(vertical: context.width(.017)),
                color: AppColors.accent,
                child: ListTile(
                  onTap: () {
                    Utility.launchURL(
                        "tel:${widget.delivery.receiverPhone ?? ""}");
                  },
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(ImageUtil.test_image),
                  ),
                  title: Text(
                    widget.delivery.receiverName ?? "",
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
      ),
    );
  }
}
