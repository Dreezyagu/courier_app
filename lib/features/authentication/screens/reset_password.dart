import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_courier/features/authentication/providers/forgot_provider.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';
import 'package:ojembaa_courier/utils/components/validators.dart';
import 'package:ojembaa_courier/utils/widgets/custom_button.dart';
import 'package:ojembaa_courier/utils/widgets/custom_textfield.dart';
import 'package:ojembaa_courier/utils/widgets/snackbar.dart';

class ResetPassword extends ConsumerStatefulWidget {
  const ResetPassword(this.otp, this.email, {super.key});

  final String otp, email;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends ConsumerState<ResetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  String password = "";
  bool obscure = true;
  bool obscure2 = true;

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
                  "Reset password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: context.width(.045),
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: context.width(.06)),
                CustomTextFormField(
                  controller: passwordController,
                  validator: Validators.notEmpty(),
                  obscureText: obscure,
                  onChange: (value) {
                    password = value;
                    setState(() {});
                  },
                  hintText: "Password",
                  prefix: Container(
                    margin: EdgeInsets.only(
                        left: context.width(.06), right: context.width(.03)),
                    child: SvgPicture.asset(
                      ImageUtil.password,
                    ),
                  ),
                  suffix: Padding(
                    padding: EdgeInsets.only(right: context.width(.02)),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        icon: Icon(
                          obscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.hintColor,
                          size: context.width(.05),
                        )),
                  ),
                ),
                SizedBox(height: context.height(.015)),
                CustomTextFormField(
                  controller: confirmPassController,
                  hintText: "Confirm password",
                  obscureText: obscure2,
                  validator: Validators.multipleAnd(
                      [Validators.notEmpty(), Validators.matchValue(password)]),
                  prefix: Container(
                    margin: EdgeInsets.only(
                        left: context.width(.06), right: context.width(.03)),
                    child: SvgPicture.asset(
                      ImageUtil.password,
                    ),
                  ),
                  suffix: Padding(
                    padding: EdgeInsets.only(right: context.width(.02)),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            obscure2 = !obscure2;
                          });
                        },
                        icon: Icon(
                          obscure2
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.hintColor,
                          size: context.width(.05),
                        )),
                  ),
                ),
                SizedBox(height: context.height(.05)),
                Consumer(
                  builder: (context, ref, child) {
                    final data = ref.watch(forgotProvider);
                    final reader = ref.read(forgotProvider.notifier);

                    return CustomContinueButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          reader.resetPass(
                              onError: (p0) => CustomSnackbar.showErrorSnackBar(
                                  context,
                                  message: p0),
                              onSuccess: () {
                                CustomSnackbar.showSuccessSnackBar(context,
                                    message: "Password reset successful");
                                Navigator.popUntil(
                                    context, ModalRoute.withName("/loginPage"));
                              },
                              password: confirmPassController.text,
                              otp: widget.otp);
                        }
                      },
                      isActive: !data.isLoading,
                      sidePadding: 0,
                      elevation: 0,
                      disabledBgColor: AppColors.hintColor.withOpacity(.5),
                      bgColor: AppColors.accent,
                      title: "Reset Password",
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
