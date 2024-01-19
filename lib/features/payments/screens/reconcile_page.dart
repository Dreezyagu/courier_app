import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ojembaa_courier/features/authentication/providers/upload_asset_provider.dart';
import 'package:ojembaa_courier/features/authentication/widgets/create_account_widgets.dart';
import 'package:ojembaa_courier/features/authentication/widgets/image_picker_widget.dart';
import 'package:ojembaa_courier/features/payments/providers/get_transactions_provider.dart';
import 'package:ojembaa_courier/features/payments/providers/reconciliation_provider.dart';
import 'package:ojembaa_courier/features/payments/screens/reconciliation_success.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/number_formatter.dart';
import 'package:ojembaa_courier/utils/components/utitlity.dart';
import 'package:ojembaa_courier/utils/components/validators.dart';
import 'package:ojembaa_courier/utils/helpers/storage/storage_helper.dart';
import 'package:ojembaa_courier/utils/helpers/storage/storage_keys.dart';
import 'package:ojembaa_courier/utils/widgets/custom_appbar.dart';
import 'package:ojembaa_courier/utils/widgets/custom_button.dart';
import 'package:ojembaa_courier/utils/widgets/custom_textfield.dart';
import 'package:ojembaa_courier/utils/widgets/snackbar.dart';
import 'package:ojembaa_courier/utils/widgets/white_pill.dart';

class ReconcilePage extends ConsumerStatefulWidget {
  const ReconcilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReconcilePageState();
}

class _ReconcilePageState extends ConsumerState<ReconcilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController amountController = TextEditingController();
  File? _file;
  String? picUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white_background,
      key: _scaffoldKey,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.width(.06), vertical: context.width(.02)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pay into this account to reconcile this order.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.width(.04),
                  color: AppColors.accent,
                ),
              ),
              SizedBox(height: context.width(.02)),
              WhitePill(
                  width: double.infinity,
                  color: const Color(0xffD9D9D9).withOpacity(.51),
                  padding: EdgeInsets.symmetric(
                      horizontal: context.width(.06),
                      vertical: context.width(.04)),
                  borderRadius: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextColumn(
                        title: "Bank",
                        subtitle: "Wema bank",
                      ),
                      SizedBox(height: context.width(.04)),
                      const TextColumn(
                        title: "Account name",
                        subtitle: "Ojembaa Logistic company",
                      ),
                      SizedBox(height: context.width(.04)),
                      const TextColumn(
                        title: "Account name",
                        subtitle: "826293200",
                      ),
                    ],
                  )),
              SizedBox(height: context.width(.04)),
              CustomTextFormField(
                controller: amountController,
                // borderColor: AppColors.white,
                validator: Validators.notEmpty(),
                keyboardType: TextInputType.number,
                hintText: "Enter amount",

                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyInputFormatter()
                ],
              ),
              SizedBox(height: context.width(.06)),
              Text(
                "Upload proof of payment",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.width(.04),
                  color: AppColors.accent,
                ),
              ),
              SizedBox(height: context.width(.02)),
              Consumer(builder: (context, ref, child) {
                const String key = "Receipt Pic";
                final reader = ref.read(uploadAssetProvider(key).notifier);
                final data = ref.watch(uploadAssetProvider(key));

                return InkWell(
                    onTap: () {
                      if (Platform.isIOS) {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) => ImagePickerWidget(
                                  onImageSelected: (XFile val) {
                                    _file = File(val.path);
                                    picUrl = null;
                                    if (_file != null) {
                                      reader.uploadPicture(
                                          file: _file!,
                                          onSuccess: (String url) {
                                            setState(() {
                                              picUrl = url;
                                            });

                                            CustomSnackbar.showSuccessSnackBar(
                                                _scaffoldKey.currentContext!,
                                                message: "Upload successful");
                                          },
                                          onError: (p0) {
                                            _file = null;
                                            picUrl = null;

                                            CustomSnackbar.showErrorSnackBar(
                                                _scaffoldKey.currentContext!,
                                                message: p0);
                                          });
                                    }
                                  },
                                  onCanceled: () => Navigator.pop(context),
                                ));
                      } else {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => ImagePickerWidget(
                                  onImageSelected: (XFile val) {
                                    _file = File(val.path);
                                    picUrl = null;
                                    if (_file != null) {
                                      reader.uploadPicture(
                                          file: _file!,
                                          onSuccess: (String url) {
                                            setState(() {
                                              picUrl = url;
                                            });

                                            CustomSnackbar.showSuccessSnackBar(
                                                _scaffoldKey.currentContext!,
                                                message: "Upload successful");
                                          },
                                          onError: (p0) {
                                            _file = null;
                                            picUrl = null;

                                            CustomSnackbar.showErrorSnackBar(
                                                _scaffoldKey.currentContext!,
                                                message: p0);
                                          });
                                    }
                                  },
                                  onCanceled: () => Navigator.pop(context),
                                ));
                      }
                    },
                    child: picUrl != null
                        ? SizedBox(
                            height: context.width(.7),
                            width: double.infinity,
                            child: Image.file(_file!))
                        : AddPictureWidget(
                            isLoading: data.isLoading,
                          ));
              }),
              SizedBox(height: context.width(.06)),
              Consumer(builder: (context, ref, child) {
                final reader = ref.read(reconciliationProvider.notifier);
                final data = ref.watch(reconciliationProvider);

                return CustomContinueButton(
                  onPressed: () async {
                    final userId =
                        await StorageHelper.getString(StorageKeys.userId);
                    reader.reconciliation(
                      userId!,
                      {
                        "proof": picUrl,
                        "amount": Utility.convertToRealNumber(
                                amountController.text.trim())
                            .floor()
                      },
                      onError: (p0) {
                        CustomSnackbar.showErrorSnackBar(context, message: p0);
                      },
                      onSuccess: () {
                        ref
                            .read(getTransactionsProvider.notifier)
                            .getTransactions(
                              userId,
                              onSuccess: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ReconciliationSuccess(),
                                    ));
                              },
                              onError: (p0) => CustomSnackbar.showErrorSnackBar(
                                  context,
                                  message: p0),
                            );
                      },
                    );
                  },
                  sidePadding: 0,
                  isActive: !data.isLoading,
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class TextColumn extends StatelessWidget {
  const TextColumn({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: context.width(.04),
            fontWeight: FontWeight.w700,
            color: AppColors.accent,
          ),
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: context.width(.04),
            color: AppColors.accent,
          ),
        ),
      ],
    );
  }
}
