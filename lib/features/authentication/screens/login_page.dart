import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_courier/features/authentication/screens/signup_page.dart';
import 'package:ojembaa_courier/features/homepage/screens/nav_page.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';
import 'package:ojembaa_courier/utils/widgets/custom_button.dart';
import 'package:ojembaa_courier/utils/widgets/custom_textfield.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width(.06)),
              child: Column(
                children: [
                  SizedBox(height: context.height(.03)),
                  SvgPicture.asset(
                    ImageUtil.icon_title_accent,
                  ),
                  SizedBox(height: context.height(.048)),
                  Text(
                    "Sign In",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: context.width(.045),
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: context.height(.02)),
                  CustomTextFormField(
                    controller: emailController,
                    hintText: "Email",
                    prefix: Container(
                      margin: EdgeInsets.only(
                          left: context.width(.06), right: context.width(.03)),
                      child: SvgPicture.asset(
                        ImageUtil.email,
                      ),
                    ),
                  ),
                  SizedBox(height: context.height(.03)),
                  CustomTextFormField(
                    controller: passwordController,
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
                          onPressed: () {},
                          icon: Icon(
                            Icons.visibility_outlined,
                            color: AppColors.hintColor,
                            size: context.width(.05),
                          )),
                    ),
                  ),
                  SizedBox(height: context.height(.025)),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Forgot your password?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: context.width(.04),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(height: context.height(.01)),
                  CustomContinueButton2(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            settings: const RouteSettings(name: "/mainPage"),
                            builder: (context) => const NavPage(),
                          ));
                    },
                    sidePadding: 0,
                    elevation: 0,
                    bgColor: AppColors.accent,
                    title: "Sign In",
                  ),
                  SizedBox(height: context.height(.02)),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupPage(),
                          ));
                    },
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                fontSize: context.width(.037),
                                color: AppColors.black),
                            children: const [
                          TextSpan(text: "Don't have an account?"),
                          TextSpan(
                              text: " Sign up",
                              style: TextStyle(color: AppColors.red)),
                        ])),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset(
                ImageUtil.big_icon_transparent,
                height: context.height(.3),
              ))
        ],
      ),
    );
  }
}
