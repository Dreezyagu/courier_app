import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_courier/features/authentication/providers/user_provider.dart';
import 'package:ojembaa_courier/features/authentication/providers/vehicle_provider.dart';
import 'package:ojembaa_courier/features/authentication/widgets/create_account_widgets.dart';
import 'package:ojembaa_courier/features/homepage/providers/get_requests_provider.dart';
import 'package:ojembaa_courier/features/homepage/screens/nav_page.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';
import 'package:ojembaa_courier/utils/components/validators.dart';
import 'package:ojembaa_courier/utils/widgets/circle.dart';
import 'package:ojembaa_courier/utils/widgets/custom_appbar.dart';
import 'package:ojembaa_courier/utils/widgets/custom_button.dart';
import 'package:ojembaa_courier/utils/widgets/custom_textfield.dart';
import 'package:ojembaa_courier/utils/widgets/snackbar.dart';

class GuarantorInfo extends ConsumerStatefulWidget {
  const GuarantorInfo({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GuarantorInfoState();
}

class _GuarantorInfoState extends ConsumerState<GuarantorInfo> {
  bool? check = false;
  final TextEditingController email = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController relationship = TextEditingController();
  final TextEditingController occupation = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white_background,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.width(.06),
                  vertical: context.height(.015)),
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
                      "We require information about your guarantor, just in case there are any unforeseen issues.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: context.width(.04), color: AppColors.black),
                    ),
                    SizedBox(height: context.height(.035)),
                    const StageBarWidget(level: 5),
                    SizedBox(height: context.height(.015)),
                    Row(
                      children: [
                        Circle(
                            borderColor: AppColors.accent,
                            width: context.width(.07),
                            color: AppColors.primary,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: SvgPicture.asset(ImageUtil.guarantor),
                            )),
                        SizedBox(width: context.width(.02)),
                        Text(
                          "Enter details of your guarantor",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: context.width(.035),
                              color: AppColors.accent),
                        ),
                      ],
                    ),
                    SizedBox(height: context.height(.05)),
                    CustomTextFormField(
                      controller: firstName,
                      hintText: "First Name",
                      validator: Validators.notEmpty(),
                    ),
                    SizedBox(height: context.height(.015)),
                    CustomTextFormField(
                      controller: lastName,
                      validator: Validators.notEmpty(),
                      hintText: "Last Name",
                    ),
                    SizedBox(height: context.height(.015)),
                    CustomTextFormField(
                      controller: relationship,
                      validator: Validators.notEmpty(),
                      hintText: "Relationship",
                    ),
                    SizedBox(height: context.height(.015)),
                    CustomTextFormField(
                      controller: occupation,
                      validator: Validators.notEmpty(),
                      hintText: "Occupation",
                    ),
                    SizedBox(height: context.height(.015)),
                    CustomTextFormField(
                      controller: address,
                      validator: Validators.notEmpty(),
                      hintText: "Address",
                    ),
                    SizedBox(height: context.height(.015)),
                    CustomTextFormField(
                      controller: phone,
                      hintText: "Phone number",
                      maxLength: 11,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.phone,
                      validator: Validators.notEmpty(),
                    ),
                    SizedBox(height: context.height(.015)),
                    CustomTextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.multipleAnd(
                          [Validators.notEmpty(), Validators.email()]),
                      hintText: "Email",
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width(.03)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                      value: check,
                      checkColor: AppColors.white,
                      activeColor: AppColors.primary,
                      onChanged: (bool? value) {
                        setState(() {
                          check = value;
                        });
                      }),
                  Expanded(
                    child: Text(
                      "I affirm that the information provide is true and conscent is given to make call to the guarantor provided.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: context.width(.032),
                          fontWeight: FontWeight.w300,
                          color: AppColors.hintColor),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.height(.03)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width(.06)),
              child: Consumer(builder: (context, ref, child) {
                final data = ref.watch(vehicleProvider);
                final reader = ref.read(vehicleProvider.notifier);
                return CustomContinueButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      reader.addGuarantor(
                        payload: {
                          "firstName": firstName.text.trim(),
                          "lastName": lastName.text.trim(),
                          "relationship": relationship.text.trim(),
                          "occupation": occupation.text.trim(),
                          "address": address.text.trim(),
                          "phone": phone.text.trim(),
                          "email": email.text.trim()
                        },
                        onSuccess: () {
                          ref.read(getRequestsProvider.notifier).getRequests();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                settings:
                                    const RouteSettings(name: "/mainPage"),
                                builder: (context) => const NavPage(),
                              ));
                        },
                        onError: (p0) {
                          CustomSnackbar.showErrorSnackBar(context,
                              message: p0);
                        },
                      );
                    }
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const GuarantorInfo(),
                    //     ));
                  },
                  sidePadding: 0,
                  isActive: !data.isLoading,
                  disabledBgColor: AppColors.hintColor.withOpacity(.5),
                );
              }),
            ),
            SizedBox(height: context.height(.06)),
          ],
        ),
      ),
    );
  }
}
