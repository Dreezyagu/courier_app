import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';
import 'package:ojembaa_courier/utils/widgets/white_pill.dart';

class AddPictureWidget extends StatelessWidget {
  const AddPictureWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WhitePill(
        width: double.infinity,
        height: context.width(.7),
        borderRadius: 20,
        color: AppColors.primary.withOpacity(.18),
        boxBorder: Border.all(color: AppColors.primary),
        child: Padding(
          padding: EdgeInsets.all(context.height(.13)),
          child: SvgPicture.asset(
            ImageUtil.add_picture,
          ),
        ));
  }
}

class StageBarWidget extends StatelessWidget {
  const StageBarWidget({
    super.key,
    required this.level,
  });
  final int level;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
          5,
          (index) => Container(
                margin: EdgeInsets.only(right: context.width(.02)),
                height: context.height(.004),
                width: context.width(.09),
                decoration: BoxDecoration(
                    color: index < level
                        ? AppColors.primary
                        : const Color(0xffB2B2B2),
                    borderRadius: BorderRadius.circular(10)),
              )),
    );
  }
}
