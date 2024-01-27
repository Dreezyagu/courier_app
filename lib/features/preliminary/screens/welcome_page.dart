import 'package:flutter/material.dart';
import 'package:ojembaa_courier/features/preliminary/widgets/welcome_widget.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.accent,
        body: Padding(
          padding: EdgeInsets.only(top: context.height(.05)),
          child: Stack(
            children: [
              Image.asset(
                ImageUtil.man_with_box,
              ),
              const WelcomeWidget()
            ],
          ),
        ),
      ),
    );
  }
}
