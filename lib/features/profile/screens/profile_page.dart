// ignore_for_file: unnecessary_string_interpolations

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ojembaa_courier/features/authentication/providers/user_provider.dart';
import 'package:ojembaa_courier/features/profile/widgets/profile_tile.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';
import 'package:ojembaa_courier/utils/widgets/custom_appbar.dart';
import 'package:ojembaa_courier/utils/widgets/custom_button.dart';
import 'package:ojembaa_courier/utils/widgets/custom_textfield.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        bgColor: AppColors.white,
        leading: const SizedBox.shrink(),
        title: Text(
          "Profile",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: context.width(.05)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.width(.04), vertical: context.width(.06)),
          child: Consumer(
            builder: (context, ref, child) {
              final data = ref.watch(userProvider).data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: context.width(.35),
                      width: context.width(.35),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: data?.profilePhoto ?? "",
                          placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: const ColoredBox(
                                color: AppColors.white,
                              )),
                          errorWidget: (context, url, error) => const SizedBox(
                            child: ColoredBox(color: AppColors.hintColor),
                          ),
                          fit: BoxFit.fill,
                        ),
                      )),
                  SizedBox(height: context.width(.1)),
                  ProfileTile(
                    title: "Full name",
                    subtitle:
                        "${data?.firstName ?? ""} ${data?.lastName ?? ""}",
                  ),
                  ProfileTile(
                    title: "Email",
                    subtitle: "${data?.email ?? ""}",
                  ),
                  ProfileTile(
                    title: "Phone Number",
                    subtitle: "${data?.phone ?? ""}",
                  ),
                  SizedBox(
                    height: context.width(.1),
                    child: const Divider(thickness: .3),
                  ),
                  ProfileTile(
                    title: "Sign out",
                    subtitle: "Sign out of your account",
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) => AlertDialog(
                          backgroundColor: AppColors.white,
                          title: Text(
                            "Log out",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: context.width(.045)),
                          ),
                          content: Text(
                            "Are you sure you want to log out?",
                            style: TextStyle(fontSize: context.width(.04)),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "No",
                                  style:
                                      TextStyle(fontSize: context.width(.038)),
                                )),
                            TextButton(
                                onPressed: () {
                                  Navigator.popUntil(context,
                                      ModalRoute.withName("/loginPage"));
                                },
                                child: Text(
                                  "Yes",
                                  style:
                                      TextStyle(fontSize: context.width(.038)),
                                )),
                          ],
                        ),
                      );
                    },
                  ),
                  ProfileTile(
                    title: "Delete your account",
                    subtitle: "Deactivate your account",
                    subtitleColor: const Color(0xffFF6666),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: AppColors.white,
                          title: Text(
                            "Delete Account",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: context.width(.045)),
                          ),
                          content: Text(
                            "Are you sure you want to delete your account?",
                            style: TextStyle(fontSize: context.width(.04)),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "No",
                                  style:
                                      TextStyle(fontSize: context.width(.038)),
                                )),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                        builder: (context, setState) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 24),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Kindly enter your password",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                      context.width(.045)),
                                            ),
                                            const SizedBox(height: 30),
                                            CustomTextFormField(
                                              controller: passwordController,
                                              hintText: "Password",
                                              obscureText: true,
                                              prefix: Container(
                                                margin: EdgeInsets.only(
                                                    left: context.width(.06),
                                                    right: context.width(.03)),
                                                child: SvgPicture.asset(
                                                  ImageUtil.password,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 60),
                                            CustomContinueButton(
                                              onPressed: () {
                                                if (passwordController
                                                    .text.isNotEmpty) {
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                  Future.delayed(
                                                    const Duration(seconds: 90),
                                                    () {
                                                      Navigator.popUntil(
                                                          context,
                                                          ModalRoute.withName(
                                                              "/loginPage"));
                                                    },
                                                  );
                                                }
                                              },
                                              isActive: !isLoading,
                                              title: "Delete Account",
                                              sidePadding: 0,
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                                  );
                                },
                                child: Text(
                                  "Yes",
                                  style:
                                      TextStyle(fontSize: context.width(.038)),
                                )),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
