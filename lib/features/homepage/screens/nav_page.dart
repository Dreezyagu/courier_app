import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ojembaa_courier/features/authentication/providers/user_provider.dart';
import 'package:ojembaa_courier/features/homepage/screens/homepage.dart';
import 'package:ojembaa_courier/features/payments/screens/payments_page.dart';
import 'package:ojembaa_courier/features/profile/screens/profile_page.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';
import 'package:ojembaa_courier/utils/widgets/asset_icon.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final watcher = ref.watch(userProvider);
      return Scaffold(
        body: PopScope(
            canPop: false,
            child: Stack(
              children: [
                getBody(),
                //TODO
                if (watcher.data?.isActivated == true)
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: AppColors.primary.withOpacity(.88),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AssetIcon(
                          icon: "under_review",
                          size: context.width(.5),
                        ),
                        Text(
                          "Your account is under review",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: context.width(.05),
                              color: AppColors.accent,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          " will be processed under 24-48 hours",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: context.width(.04),
                              color: AppColors.accent,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  )
              ],
            )),

        // TODO
        bottomNavigationBar: watcher.data?.isActivated == true
            ? null
            : BottomNavigationBar(
                currentIndex: selectedIndex,
                backgroundColor: AppColors.white,
                selectedItemColor: AppColors.black,
                unselectedItemColor: AppColors.black,
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.w600),
                selectedIconTheme:
                    const IconThemeData(color: AppColors.primary),
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      icon: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: context.width(.02)),
                          child: SvgPicture.asset(
                            ImageUtil.home,
                            colorFilter: ColorFilter.mode(
                                selectedIndex == 0
                                    ? AppColors.primary
                                    : AppColors.default_icon,
                                BlendMode.srcIn),
                          )),
                      label: "Home"),
                  BottomNavigationBarItem(
                      icon: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: context.width(.02)),
                          child: SvgPicture.asset(ImageUtil.wallet,
                              colorFilter: ColorFilter.mode(
                                  selectedIndex == 1
                                      ? AppColors.primary
                                      : AppColors.default_icon,
                                  BlendMode.srcIn))),
                      label: "Payments"),
                  BottomNavigationBarItem(
                      icon: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: context.width(.02)),
                          child: SvgPicture.asset(ImageUtil.deliveries,
                              colorFilter: ColorFilter.mode(
                                  selectedIndex == 2
                                      ? AppColors.primary
                                      : AppColors.default_icon,
                                  BlendMode.srcIn))),
                      label: "Deliveries"),
                  BottomNavigationBarItem(
                      icon: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: context.width(.02)),
                          child: SvgPicture.asset(ImageUtil.profile)),
                      label: "Profile"),
                ],
                onTap: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
      );
    });
  }

  Widget getBody() {
    if (selectedIndex == 0) {
      return const Homepage();
    } else if (selectedIndex == 1) {
      return const PaymentsPage();
    } else if (selectedIndex == 2) {
      return const Homepage();
    } else if (selectedIndex == 3) {
      return const ProfilePage();
    } else {
      return const Homepage();
    }
  }
}
