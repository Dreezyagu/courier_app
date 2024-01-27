import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/homepage/providers/accept_delivery_provider.dart';
import 'package:ojembaa_courier/features/homepage/providers/get_requests_provider.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/widgets/custom_button.dart';
import 'package:ojembaa_courier/utils/widgets/snackbar.dart';

class DeclineDialog extends StatefulWidget {
  const DeclineDialog({
    super.key,
    required this.deliveryId,
    required this.onSuccess,
  });
  final String deliveryId;
  final VoidCallback onSuccess;
  @override
  State<DeclineDialog> createState() => _DeclineDialogState();
}

class _DeclineDialogState extends State<DeclineDialog> {
  String? groupValue;

  List<String> radioItems = [
    "Distance too long",
    "Vehicle issues",
    "Package type",
    "I can't make an express delivery now",
    "Other"
  ];
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return SimpleDialog(
          backgroundColor: AppColors.white,
          title: Center(
            child: Text(
              "Reason for declining",
              style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: context.width(.045)),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: context.width(.04)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          children: [
            SizedBox(height: context.width(.06)),
            Column(
              children: radioItems
                  .map((e) => RadioButton<String?>(
                      label: e,
                      groupValue: groupValue,
                      value: e,
                      onChanged: (val) {
                        setState(
                          () {
                            groupValue = val;
                          },
                        );
                      }))
                  .toList(),
            ),
            Consumer(builder: (context, ref, child) {
              return CustomContinueButton(
                onPressed: () {
                  ref
                      .read(acceptDeliveryProvider("reject").notifier)
                      .acceptDelivery(
                          id: widget.deliveryId,
                          status: "reject",
                          onSuccess: () {
                            ref
                                .read(getRequestsProvider.notifier)
                                .getRequests();
                            widget.onSuccess();
                          },
                          onError: (p0) {
                            Navigator.pop(context);
                            CustomSnackbar.showErrorSnackBar(context,
                                message: p0);
                          });
                },
                topPadding: context.width(.06),
                isActive:
                    !ref.watch(acceptDeliveryProvider("reject")).isLoading,
                elevation: 0,
                bgColor: const Color(0xff707070),
                innerTopPadding: context.width(.035),
                sidePadding: 10,
                title: "Submit",
              );
            })
          ]);
    });
  }
}

class RadioButton<T> extends StatelessWidget {
  final String label;
  final EdgeInsets? padding;
  final T groupValue;
  final T value;
  final ValueChanged<T> onChanged;

  const RadioButton(
      {Key? key,
      required this.label,
      this.padding = const EdgeInsets.symmetric(vertical: 0),
      required this.groupValue,
      required this.value,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      value: value,
      activeColor: AppColors.primary,
      contentPadding: padding,
      groupValue: groupValue,
      onChanged: (T? newValue) {
        onChanged(newValue as T);
      },
      title: Text(
        label,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: context.width(.038),
            color: AppColors.black),
      ),
    );
  }
}
