import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ojembaa_courier/features/authentication/providers/upload_asset_provider.dart';
import 'package:ojembaa_courier/features/authentication/providers/user_provider.dart';
import 'package:ojembaa_courier/features/authentication/screens/upload_id.dart';
import 'package:ojembaa_courier/features/authentication/widgets/create_account_widgets.dart';
import 'package:ojembaa_courier/features/authentication/widgets/image_picker_widget.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';
import 'package:ojembaa_courier/utils/widgets/circle.dart';
import 'package:ojembaa_courier/utils/widgets/custom_appbar.dart';
import 'package:ojembaa_courier/utils/widgets/custom_button.dart';
import 'package:ojembaa_courier/utils/widgets/snackbar.dart';

class UploadPicture extends ConsumerStatefulWidget {
  const UploadPicture({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadPictureState();
}

class _UploadPictureState extends ConsumerState<UploadPicture> {
  File? _file;
  String? profilePicUrl;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.white_background,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.width(.06), vertical: context.height(.015)),
        child: SingleChildScrollView(
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
                  "Just a few more steps\nto set up your account.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: context.width(.04), color: AppColors.black),
                ),
                SizedBox(height: context.height(.035)),
                const StageBarWidget(level: 1),
                SizedBox(height: context.height(.015)),
                Row(
                  children: [
                    Circle(
                        borderColor: AppColors.accent,
                        width: context.width(.07),
                        color: AppColors.primary,
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: SvgPicture.asset(ImageUtil.camera),
                        )),
                    SizedBox(width: context.width(.02)),
                    Text(
                      "Upload a nice headshot",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: context.width(.035),
                          color: AppColors.accent),
                    ),
                  ],
                ),
                SizedBox(height: context.height(.05)),
                Consumer(builder: (context, ref, child) {
                  const String key = "Profile Pic";
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
                                      profilePicUrl = null;
                                      if (_file != null) {
                                        reader.uploadPicture(
                                            file: _file!,
                                            onSuccess: (String url) {
                                              setState(() {
                                                profilePicUrl = url;
                                              });

                                              CustomSnackbar
                                                  .showSuccessSnackBar(
                                                      _scaffoldKey
                                                          .currentContext!,
                                                      message:
                                                          "Upload successful");
                                            },
                                            onError: (p0) {
                                              _file = null;
                                              profilePicUrl = null;

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
                                      profilePicUrl = null;
                                      if (_file != null) {
                                        reader.uploadPicture(
                                            file: _file!,
                                            onSuccess: (String url) {
                                              setState(() {
                                                profilePicUrl = url;
                                              });

                                              CustomSnackbar
                                                  .showSuccessSnackBar(
                                                      _scaffoldKey
                                                          .currentContext!,
                                                      message:
                                                          "Upload successful");
                                            },
                                            onError: (p0) {
                                              _file = null;
                                              profilePicUrl = null;

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
                      child: profilePicUrl != null
                          ? SizedBox(
                              height: context.width(.7),
                              width: double.infinity,
                              child: Image.file(_file!))
                          : AddPictureWidget(
                              isLoading: data.isLoading,
                            ));
                }),
                SizedBox(height: context.height(.05)),
                CustomContinueButton(
                  onPressed: () {
                    if (profilePicUrl == null) {
                      CustomSnackbar.showErrorSnackBar(context,
                          message: "Please upload a picture of yourself");
                      return;
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UploadID(
                            payload: {"profilePhoto": profilePicUrl!},
                          ),
                        ));
                  },
                  sidePadding: 0,
                  disabledBgColor: AppColors.hintColor.withOpacity(.5),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
