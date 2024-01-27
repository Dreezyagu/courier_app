import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ojembaa_courier/features/preliminary/screens/welcome_page.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';
import 'package:ojembaa_courier/utils/data_util/notifications_util.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    NotificationsUtil().setUpFirebaseMessaging(context);
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WelcomePage(),
            ));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Positioned(
                top: context.height(.1),
                child: SvgPicture.asset(
                  ImageUtil.big_icon,
                  height: context.height(.92),
                ),
              ),
            ],
          ),
          SvgPicture.asset(ImageUtil.icon_title)
        ],
      ),
    );
  }
}
