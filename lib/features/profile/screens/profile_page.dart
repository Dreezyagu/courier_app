// ignore_for_file: unnecessary_string_interpolations

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/authentication/providers/user_provider.dart';
import 'package:ojembaa_courier/features/profile/widgets/profile_tile.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/widgets/custom_appbar.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        bgColor: AppColors.white,
        title: Text(
          "Profile",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: context.width(.05)),
        ),
      ),
      body: Padding(
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
                SizedBox(height: context.width(.1)),
                ProfileTile(
                  title: "Full name",
                  subtitle: "${data?.firstName ?? ""} ${data?.lastName ?? ""}",
                ),
                ProfileTile(
                  title: "Email",
                  subtitle: "${data?.email ?? ""}",
                ),
                ProfileTile(
                  title: "Phone Number",
                  subtitle: "${data?.phone ?? ""}",
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
