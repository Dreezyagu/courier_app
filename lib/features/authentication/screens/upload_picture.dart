import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_courier/features/authentication/screens/upload_id.dart';
import 'package:ojembaa_courier/features/authentication/widgets/create_account_widgets.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';
import 'package:ojembaa_courier/utils/widgets/circle.dart';
import 'package:ojembaa_courier/utils/widgets/custom_appbar.dart';
import 'package:ojembaa_courier/utils/widgets/custom_button.dart';

class UploadPicture extends ConsumerStatefulWidget {
  const UploadPicture({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadPictureState();
}

class _UploadPictureState extends ConsumerState<UploadPicture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white_background,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.width(.06), vertical: context.height(.015)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi Paschal,",
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
                      fontSize: context.width(.035), color: AppColors.accent),
                ),
              ],
            ),
            SizedBox(height: context.height(.05)),
            const AddPictureWidget(),
            SizedBox(height: context.height(.05)),
            CustomContinueButton2(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UploadID(),
                    ));
              },
              sidePadding: 0,
            )
          ],
        ),
      ),
    );
  }
}
