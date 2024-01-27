import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_courier/features/authentication/providers/forgot_provider.dart';
import 'package:ojembaa_courier/features/authentication/screens/forgot_enter_otp.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';
import 'package:ojembaa_courier/utils/components/validators.dart';
import 'package:ojembaa_courier/utils/widgets/custom_button.dart';
import 'package:ojembaa_courier/utils/widgets/custom_textfield.dart';
import 'package:ojembaa_courier/utils/widgets/snackbar.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white_background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white_background,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: context.width(.06),
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width(.06)),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SvgPicture.asset(ImageUtil.main_icon_light),
                  SizedBox(height: context.height(.04)),
                  Text(
                    "Forgot password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: context.width(.045),
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: context.width(.06)),
                  CustomTextFormField(
                    controller: emailController,
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.multipleAnd(
                        [Validators.email(), Validators.notEmpty()]),
                    prefix: Container(
                      margin: EdgeInsets.only(
                          left: context.width(.06), right: context.width(.03)),
                      child: SvgPicture.asset(
                        ImageUtil.email,
                      ),
                    ),
                  ),
                  SizedBox(height: context.height(.05)),
                  SizedBox(height: context.height(.005)),
                  Consumer(
                    builder: (context, ref, child) {
                      final data = ref.watch(forgotProvider);
                      final reader = ref.read(forgotProvider.notifier);

                      return CustomContinueButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            reader.forgotPass(
                                onError: (p0) =>
                                    CustomSnackbar.showErrorSnackBar(context,
                                        message: p0),
                                onSuccess: () {
                                  CustomSnackbar.showSuccessSnackBar(context,
                                      message: "OTP sent successfully");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ForgotEnterOTP(
                                            emailController.text),
                                      ));
                                },
                                email: emailController.text);
                          }
                        },
                        isActive: !data.isLoading,
                        sidePadding: 0,
                        elevation: 0,
                        bgColor: AppColors.accent,
                        disabledBgColor: AppColors.hintColor.withOpacity(.5),
                        title: "Send OTP",
                      );
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
