import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ojembaa_courier/features/authentication/providers/get_banks_provider.dart'; 
import 'package:ojembaa_courier/features/authentication/providers/upload_asset_provider.dart';
import 'package:ojembaa_courier/features/authentication/providers/user_provider.dart';
import 'package:ojembaa_courier/features/authentication/providers/vehicle_provider.dart';
import 'package:ojembaa_courier/features/authentication/screens/enter_bank_details.dart';
import 'package:ojembaa_courier/features/authentication/widgets/create_account_widgets.dart';
import 'package:ojembaa_courier/features/authentication/widgets/image_picker_widget.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';
import 'package:ojembaa_courier/utils/widgets/circle.dart';
import 'package:ojembaa_courier/utils/widgets/custom_appbar.dart';
import 'package:ojembaa_courier/utils/widgets/custom_button.dart';
import 'package:ojembaa_courier/utils/widgets/custom_dropdown.dart';
import 'package:ojembaa_courier/utils/widgets/snackbar.dart';

class OwnershipProof extends ConsumerStatefulWidget {
  const OwnershipProof({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OwnershipProofState();
}

class _OwnershipProofState extends ConsumerState<OwnershipProof> {
  File? ownershipFile, vehicleFile;
  String? ownershipUrl, vehicleType, vehicleUrl;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white_background,
      key: _scaffoldKey,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.width(.06), vertical: context.height(.015)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi ${ref.watch(userProvider).data?.firstName}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: context.width(.062),
                    color: AppColors.black,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: context.height(.005)),
              Text(
                "To verify your vehicle ownership status,\nplease provide an Ownership Form.",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: context.width(.04), color: AppColors.black),
              ),
              SizedBox(height: context.height(.035)),
              const StageBarWidget(level: 3),
              SizedBox(height: context.height(.015)),
              Row(
                children: [
                  Circle(
                      borderColor: AppColors.accent,
                      width: context.width(.07),
                      color: AppColors.primary,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SvgPicture.asset(ImageUtil.car),
                      )),
                  SizedBox(width: context.width(.02)),
                  Text(
                    "Vehicle ownership proof",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: context.width(.035), color: AppColors.accent),
                  ),
                ],
              ),
              SizedBox(height: context.height(.05)),
              CustomDropDownFormField<String>(
                items: ["Motocycle", "Van", "Truck"]
                    .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                value: vehicleType,
                borderColor: const Color(0xff596B6F).withOpacity(.88),
                onChanged: (String? val) {
                  vehicleType = val;
                },
                hintText: "Select vehicle type",
              ),
              SizedBox(height: context.height(.025)),
              Text(
                "Upload vehicle proof of ownership form",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.width(.037),
                  color: AppColors.accent,
                ),
              ),
              Consumer(builder: (context, ref, child) {
                const String key = "Ownership Pic";
                final reader = ref.read(uploadAssetProvider(key).notifier);
                final data = ref.watch(uploadAssetProvider(key));
                return InkWell(
                    onTap: () {
                      if (Platform.isIOS) {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) => ImagePickerWidget(
                                  onImageSelected: (XFile val) {
                                    ownershipFile = File(val.path);
                                    if (ownershipFile != null) {
                                      reader.uploadPicture(
                                          file: ownershipFile!,
                                          onSuccess: (String url) {
                                            setState(() {
                                              ownershipUrl = url;
                                            });

                                            CustomSnackbar.showSuccessSnackBar(
                                                _scaffoldKey.currentContext!,
                                                message: "Upload successful");
                                          },
                                          onError: (p0) {
                                            ownershipFile = null;
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
                                    ownershipFile = File(val.path);
                                    if (ownershipFile != null) {
                                      reader.uploadPicture(
                                          file: ownershipFile!,
                                          onSuccess: (String url) {
                                            setState(() {
                                              ownershipUrl = url;
                                            });

                                            CustomSnackbar.showSuccessSnackBar(
                                                _scaffoldKey.currentContext!,
                                                message: "Upload successful");
                                          },
                                          onError: (p0) {
                                            ownershipFile = null;
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
                    child: ownershipUrl != null
                        ? SizedBox(
                            height: context.width(.7),
                            width: double.infinity,
                            child: Image.file(ownershipFile!))
                        : AddPictureWidget(
                            isLoading: data.isLoading,
                          ));
              }),
              SizedBox(height: context.width(.08)),
              Text(
                "Upload picture of the vehicle",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.width(.037),
                  color: AppColors.accent,
                ),
              ),
              Consumer(builder: (context, ref, child) {
                const String key = "Vehicle Pic";
                final reader = ref.read(uploadAssetProvider(key).notifier);
                final data = ref.watch(uploadAssetProvider(key));
                return InkWell(
                    onTap: () {
                      if (Platform.isIOS) {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) => ImagePickerWidget(
                                  onImageSelected: (XFile val) {
                                    vehicleFile = File(val.path);
                                    if (vehicleFile != null) {
                                      reader.uploadPicture(
                                          file: vehicleFile!,
                                          onSuccess: (String url) {
                                            setState(() {
                                              vehicleUrl = url;
                                            });

                                            CustomSnackbar.showSuccessSnackBar(
                                                _scaffoldKey.currentContext!,
                                                message: "Upload successful");
                                          },
                                          onError: (p0) {
                                            vehicleFile = null;
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
                                    vehicleFile = File(val.path);
                                    if (vehicleFile != null) {
                                      reader.uploadPicture(
                                          file: vehicleFile!,
                                          onSuccess: (String url) {
                                            setState(() {
                                              vehicleUrl = url;
                                            });

                                            CustomSnackbar.showSuccessSnackBar(
                                                _scaffoldKey.currentContext!,
                                                message: "Upload successful");
                                          },
                                          onError: (p0) {
                                            vehicleFile = null;
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
                    child: vehicleUrl != null
                        ? SizedBox(
                            height: context.width(.7),
                            width: double.infinity,
                            child: Image.file(vehicleFile!))
                        : AddPictureWidget(
                            isLoading: data.isLoading,
                          ));
              }),
              SizedBox(height: context.height(.05)),
              Consumer(builder: (context, ref, child) {
                final reader = ref.read(vehicleProvider.notifier);
                final data = ref.watch(vehicleProvider);
                return CustomContinueButton(
                  onPressed: () {
                    if (vehicleType == null) {
                      CustomSnackbar.showErrorSnackBar(context,
                          message: "Please select a vehicle type");
                      return;
                    }
                    if (ownershipUrl == null || vehicleUrl == null) {
                      CustomSnackbar.showErrorSnackBar(context,
                          message: "Please upload a picture of vehicle proof");
                      return;
                    }
                    reader.createVehicle(
                      payload: {
                        "vehicleType": vehicleType,
                        "proof": ownershipUrl,
                        "image": vehicleUrl
                      },
                      onError: (p0) {
                        CustomSnackbar.showErrorSnackBar(context, message: p0);
                      },
                      onSuccess: () {
                        ref.read(getBanksProvider.notifier).getBanks();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EnterBankDetails(),
                            ));
                      },
                    );
                  },
                  isActive: !data.isLoading,
                  disabledBgColor: AppColors.hintColor.withOpacity(.5),
                  sidePadding: 0,
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
