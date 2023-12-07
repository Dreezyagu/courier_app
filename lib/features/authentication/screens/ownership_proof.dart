import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_courier/features/authentication/screens/enter_bank_details.dart';
import 'package:ojembaa_courier/features/authentication/widgets/create_account_widgets.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';
import 'package:ojembaa_courier/utils/widgets/circle.dart';
import 'package:ojembaa_courier/utils/widgets/custom_appbar.dart';
import 'package:ojembaa_courier/utils/widgets/custom_button.dart';
import 'package:ojembaa_courier/utils/widgets/custom_dropdown.dart';

class OwnershipProof extends ConsumerStatefulWidget {
  const OwnershipProof({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OwnershipProofState();
}

class _OwnershipProofState extends ConsumerState<OwnershipProof> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white_background,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
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
                "To verify your vehicle ownership status,\nplease provide an Ownership Form.",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: context.width(.04), color: AppColors.black),
              ),
              SizedBox(height: context.height(.035)),
              const StageBarWidget(level: 3),
              SizedBox(height: context.height(.015)),
              Row(
                children: [
                  Circle(
                      borderColor: AppColors.accent,
                      width: context.width(.07),
                      color: AppColors.primary,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SvgPicture.asset(ImageUtil.car),
                      )),
                  SizedBox(width: context.width(.02)),
                  Text(
                    "Vehicle ownership proof",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: context.width(.035), color: AppColors.accent),
                  ),
                ],
              ),
              SizedBox(height: context.height(.05)),
              CustomDropDownFormField(
                items: const [],
                value: 0,
                borderColor: const Color(0xff596B6F).withOpacity(.88),
                onChanged: (val) {},
                hintText: "Select vehicle type",
              ),
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
              const AddPictureWidget(),
              SizedBox(height: context.height(.05)),
              CustomContinueButton2(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EnterBankDetails(),
                      ));
                },
                sidePadding: 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
