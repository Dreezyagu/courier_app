import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ojembaa_courier/features/authentication/providers/signin_provider.dart';
import 'package:ojembaa_courier/features/authentication/providers/signup_provider.dart';
import 'package:ojembaa_courier/features/authentication/providers/update_profile_provider.dart';
import 'package:ojembaa_courier/features/authentication/providers/upload_asset_provider.dart';
import 'package:ojembaa_courier/features/authentication/providers/user_provider.dart';
import 'package:ojembaa_courier/features/authentication/screens/ownership_proof.dart';
import 'package:ojembaa_courier/features/authentication/widgets/create_account_widgets.dart';
import 'package:ojembaa_courier/features/authentication/widgets/image_picker_widget.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';
import 'package:ojembaa_courier/utils/components/validators.dart';
import 'package:ojembaa_courier/utils/widgets/circle.dart';
import 'package:ojembaa_courier/utils/widgets/custom_appbar.dart';
import 'package:ojembaa_courier/utils/widgets/custom_button.dart';
import 'package:ojembaa_courier/utils/widgets/custom_dropdown.dart';
import 'package:ojembaa_courier/utils/widgets/custom_textfield.dart';
import 'package:ojembaa_courier/utils/widgets/snackbar.dart';

class UploadID extends ConsumerStatefulWidget {
  const UploadID({required this.payload, super.key});

  final Map<String, String> payload;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadIDState();
}

class _UploadIDState extends ConsumerState<UploadID> {
  final TextEditingController idNumber = TextEditingController();
  String? idType, idFrontUrl, idBackUrl;
  File? frontFile, backFile;
  final List<DocumentType> documentTypes = [
    DocumentType("Driver's License", "DRIVERS_LICENCE"),
    DocumentType("National ID Card or NIN Slip", "NIN"),
    DocumentType("International Passport", "INTERNATIONAL_PASSPORT"),
    // DocumentType("Voter's Card", "VOTER_ID"),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.white_background,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.width(.06), vertical: context.height(.015)),
          child: Form(
            key: _formKey,
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
                  "To verify your identity and the provided\ninformation please provide an Identification card.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: context.width(.04), color: AppColors.black),
                ),
                SizedBox(height: context.height(.035)),
                const StageBarWidget(level: 2),
                SizedBox(height: context.height(.015)),
                Row(
                  children: [
                    Circle(
                        borderColor: AppColors.accent,
                        width: context.width(.07),
                        color: AppColors.primary,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: SvgPicture.asset(ImageUtil.identification),
                        )),
                    SizedBox(width: context.width(.02)),
                    Text(
                      "Identification",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: context.width(.035),
                          color: AppColors.accent),
                    ),
                  ],
                ),
                SizedBox(height: context.height(.05)),
                CustomDropDownFormField<String>(
                  items: documentTypes
                      .map((e) => DropdownMenuItem<String>(
                            value: e.tag,
                            child: Text(e.title),
                          ))
                      .toList(),
                  value: idType,
                  borderRadius: 12,
                  borderColor: const Color(0xff596B6F).withOpacity(.88),
                  onChanged: (String? val) {
                    idType = val;
                  },
                  hintText: "Select ID",
                ),
                SizedBox(height: context.height(.015)),
                CustomTextFormField(
                  controller: idNumber,
                  hintText: "ID Number",
                  keyboardType: TextInputType.number,
                  validator: Validators.notEmpty(),
                ),
                SizedBox(height: context.height(.025)),
                Text(
                  "Upload front of the ID Card",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.width(.037),
                    color: AppColors.accent,
                  ),
                ),
                SizedBox(height: context.height(.005)),
                Consumer(builder: (context, ref, child) {
                  const String key = "Front ID";

                  final reader = ref.read(uploadAssetProvider(key).notifier);
                  final data = ref.watch(uploadAssetProvider(key));

                  return InkWell(
                      onTap: () {
                        if (Platform.isIOS) {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (context) => ImagePickerWidget(
                                    onImageSelected: (XFile val) {
                                      frontFile = File(val.path);
                                      if (frontFile != null) {
                                        reader.uploadPicture(
                                            file: frontFile!,
                                            onSuccess: (String url) {
                                              setState(() {
                                                idFrontUrl = url;
                                              });

                                              CustomSnackbar
                                                  .showSuccessSnackBar(
                                                      _scaffoldKey
                                                          .currentContext!,
                                                      message:
                                                          "Upload successful");
                                            },
                                            onError: (p0) {
                                              frontFile = null;
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
                                      frontFile = File(val.path);
                                      if (frontFile != null) {
                                        reader.uploadPicture(
                                            file: frontFile!,
                                            onSuccess: (String url) {
                                              setState(() {
                                                idFrontUrl = url;
                                              });

                                              CustomSnackbar
                                                  .showSuccessSnackBar(
                                                      _scaffoldKey
                                                          .currentContext!,
                                                      message:
                                                          "Upload successful");
                                            },
                                            onError: (p0) {
                                              frontFile = null;
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
                      child: idFrontUrl != null
                          ? SizedBox(
                              height: context.width(.7),
                              width: double.infinity,
                              child: Image.file(frontFile!))
                          : AddPictureWidget(isLoading: data.isLoading));
                }),
                SizedBox(height: context.height(.025)),
                Text(
                  "Upload back of the ID Card",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.width(.037),
                    color: AppColors.accent,
                  ),
                ),
                SizedBox(height: context.height(.005)),
                Consumer(builder: (context, ref, child) {
                  const String key = "Back ID";

                  final data = ref.watch(uploadAssetProvider(key));
                  final reader = ref.read(uploadAssetProvider(key).notifier);

                  return InkWell(
                      onTap: () {
                        if (Platform.isIOS) {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (context) => ImagePickerWidget(
                                    onImageSelected: (XFile val) {
                                      backFile = File(val.path);

                                      if (backFile != null) {
                                        reader.uploadPicture(
                                            file: backFile!,
                                            onSuccess: (String url) {
                                              setState(() {
                                                idBackUrl = url;
                                              });

                                              CustomSnackbar
                                                  .showSuccessSnackBar(
                                                      _scaffoldKey
                                                          .currentContext!,
                                                      message:
                                                          "Upload successful");
                                            },
                                            onError: (p0) {
                                              backFile = null;
                                              idBackUrl = null;
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
                                      backFile = File(val.path);
                                      if (backFile != null) {
                                        reader.uploadPicture(
                                            file: backFile!,
                                            onSuccess: (String url) {
                                              setState(() {
                                                idBackUrl = url;
                                              });

                                              CustomSnackbar
                                                  .showSuccessSnackBar(
                                                      _scaffoldKey
                                                          .currentContext!,
                                                      message:
                                                          "Upload successful");
                                            },
                                            onError: (p0) {
                                              backFile = null;
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
                      child: idBackUrl != null
                          ? SizedBox(
                              height: context.width(.7),
                              width: double.infinity,
                              child: Image.file(backFile!))
                          : AddPictureWidget(isLoading: data.isLoading));
                }),
                SizedBox(height: context.height(.05)),
                Consumer(builder: (context, ref, child) {
                  const String uploadID = "Upload ID";
                  final data = ref.watch(updateProfileProvider(uploadID));
                  final reader =
                      ref.read(updateProfileProvider(uploadID).notifier);
                  return CustomContinueButton(
                    onPressed: () {
                      if ((_formKey.currentState?.validate() == true)) {
                        if (idType == null) {
                          CustomSnackbar.showErrorSnackBar(context,
                              message: "Please select an ID Type");
                          return;
                        }

                        if (idFrontUrl == null || idBackUrl == null) {
                          CustomSnackbar.showErrorSnackBar(context,
                              message: "Please upload the images of your ID");
                          return;
                        }

                        final payload = widget.payload;
                        payload["idType"] = idType!;
                        payload["idNumber"] = idNumber.text;
                        payload["idImageFront"] = idFrontUrl!;
                        payload["idImageBack"] = idBackUrl!;

                        reader.updateProfile(
                          payload: payload,
                          id: ref.watch(signUpProvider).data?.id ??
                              ref.watch(signInProvider).data?.id ??
                              "",
                          onSuccess: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const OwnershipProof(),
                                ));
                          },
                          onError: (p0) {
                            CustomSnackbar.showErrorSnackBar(context,
                                message: p0);
                          },
                        );
                      }
                    },
                    isActive: !data.isLoading,
                    sidePadding: 0,
                    disabledBgColor: AppColors.hintColor.withOpacity(.5),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DocumentType {
  final String title;
  final String tag;

  DocumentType(this.title, this.tag);
}
