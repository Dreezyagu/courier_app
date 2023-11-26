import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ojembaa_courier/features/homepage/screens/homepage.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          WillPopScope(onWillPop: () => Future.value(false), child: getBody()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.black,
        unselectedItemColor: AppColors.black,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        selectedIconTheme: const IconThemeData(color: AppColors.primary),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: context.width(.02)),
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
                  padding: EdgeInsets.symmetric(vertical: context.width(.02)),
                  child: SvgPicture.asset(ImageUtil.wallet,
                      colorFilter: ColorFilter.mode(
                          selectedIndex == 1
                              ? AppColors.primary
                              : AppColors.default_icon,
                          BlendMode.srcIn))),
              label: "Payments"),
          BottomNavigationBarItem(
              icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: context.width(.02)),
                  child: SvgPicture.asset(ImageUtil.deliveries,
                      colorFilter: ColorFilter.mode(
                          selectedIndex == 2
                              ? AppColors.primary
                              : AppColors.default_icon,
                          BlendMode.srcIn))),
              label: "Deliveries"),
          BottomNavigationBarItem(
              icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: context.width(.02)),
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
  }

  Widget getBody() {
    if (selectedIndex == 0) {
      return const Homepage();
    } else if (selectedIndex == 1) {
      return const Homepage();
    } else if (selectedIndex == 2) {
      return const Homepage();
    } else {
      return const Homepage();
    }
  }
}
