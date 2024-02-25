import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_courier/features/authentication/providers/signup_provider.dart';
import 'package:ojembaa_courier/features/authentication/screens/enter_otp.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';
import 'package:ojembaa_courier/utils/components/utitlity.dart';
import 'package:ojembaa_courier/utils/components/validators.dart';
import 'package:ojembaa_courier/utils/widgets/custom_appbar.dart';
import 'package:ojembaa_courier/utils/widgets/custom_button.dart';
import 'package:ojembaa_courier/utils/widgets/custom_textfield.dart';
import 'package:ojembaa_courier/utils/widgets/snackbar.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscure = true;
  bool obscure2 = true;
  bool? checkedValue = false;

  @override
  void dispose() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPassController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white_background,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width(.06)),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SvgPicture.asset(
                  ImageUtil.main_icon_light,
                  height: context.height(.06),
                ),
                SizedBox(height: context.height(.04)),
                Text(
                  "Sign up",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: context.width(.045),
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: context.height(.03)),
                CustomTextFormField(
                  controller: firstNameController,
                  validator: Validators.notEmpty(),
                  hintText: "First Name",
                  prefix: Container(
                    margin: EdgeInsets.only(
                        left: context.width(.06), right: context.width(.03)),
                    child: SvgPicture.asset(
                      ImageUtil.person,
                    ),
                  ),
                ),
                SizedBox(height: context.height(.015)),
                CustomTextFormField(
                  controller: lastNameController,
                  validator: Validators.notEmpty(),
                  hintText: "Last Name",
                  prefix: Container(
                    margin: EdgeInsets.only(
                        left: context.width(.06), right: context.width(.03)),
                    child: SvgPicture.asset(
                      ImageUtil.person,
                    ),
                  ),
                ),
                SizedBox(height: context.height(.015)),
                CustomTextFormField(
                  controller: phoneController,
                  maxLength: 11,
                  validator: Validators.multipleAnd(
                      [Validators.notEmpty(), Validators.matchLength(11)]),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  hintText: "Phone number",
                  prefix: Container(
                    margin: EdgeInsets.only(
                        left: context.width(.06), right: context.width(.03)),
                    child: SvgPicture.asset(
                      ImageUtil.phone_number,
                    ),
                  ),
                ),
                SizedBox(height: context.height(.015)),
                CustomTextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.multipleAnd(
                      [Validators.email(), Validators.notEmpty()]),
                  hintText: "Email",
                  prefix: Container(
                    margin: EdgeInsets.only(
                        left: context.width(.06), right: context.width(.03)),
                    child: SvgPicture.asset(
                      ImageUtil.email,
                    ),
                  ),
                ),
                SizedBox(height: context.height(.015)),
                CustomTextFormField(
                  controller: passwordController,
                  obscureText: obscure,
                  hintText: "Password",
                  validator: Validators.notEmpty(),
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
                          !obscure
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
                  validator: Validators.notEmpty(),
                  obscureText: obscure2,
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
                          !obscure2
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.hintColor,
                          size: context.width(.05),
                        )),
                  ),
                ),
                SizedBox(height: context.height(.05)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                        value: checkedValue,
                        checkColor: AppColors.white, // color of tick Mark
                        activeColor: AppColors.primary,
                        onChanged: (bool? value) {
                          setState(() {
                            checkedValue = value;
                          });
                        }),
                    Expanded(
                      child: InkWell(
                        onTap: () => Utility.launchURL(
                            "https://www.ojembaa.com/terms-conditions"),
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontSize: context.width(.037),
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                            children: const [
                              TextSpan(
                                text: "I agree with Ojembaa's ",
                                style: TextStyle(),
                              ),
                              TextSpan(
                                text: "terms, conditions ",
                                style: TextStyle(
                                  color: AppColors.primary,
                                ),
                              ),
                              TextSpan(
                                text: "and ",
                                style: TextStyle(),
                              ),
                              TextSpan(
                                text: " privacy policy",
                                style: TextStyle(
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final data = ref.watch(signUpProvider);
                    final reader = ref.read(signUpProvider.notifier);

                    return CustomContinueButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          if (checkedValue != true) {
                            CustomSnackbar.showErrorSnackBar(context,
                                message:
                                    "Please accept the terms and conditions");
                            return;
                          }
                          reader.signUp(
                              onError: (p0) => CustomSnackbar.showErrorSnackBar(
                                  context,
                                  message: p0),
                              onSuccess: () {
                                CustomSnackbar.showSuccessSnackBar(context,
                                    message: "Account created successfully");

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EnterOTP(passwordController.text),
                                    ));
                              },
                              firstName: firstNameController.text.trim(),
                              lastName: lastNameController.text.trim(),
                              phone: phoneController.text.trim(),
                              email: emailController.text.trim(),
                              password: confirmPassController.text);
                        }
                      },
                      isActive: !data.isLoading,
                      sidePadding: 0,
                      elevation: 0,
                      disabledBgColor: AppColors.hintColor.withOpacity(.5),
                      bgColor: AppColors.accent,
                      title: "Sign Up",
                    );
                  },
                ),
                SizedBox(height: context.height(.005)),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    "Sign in instead",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: context.width(.04),
                        color: AppColors.hintColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
