import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_courier/features/authentication/providers/get_banks_provider.dart';
import 'package:ojembaa_courier/features/authentication/providers/signin_provider.dart';
import 'package:ojembaa_courier/features/authentication/providers/user_provider.dart';
import 'package:ojembaa_courier/features/authentication/screens/enter_bank_details.dart';
import 'package:ojembaa_courier/features/authentication/screens/forgot_password.dart';
import 'package:ojembaa_courier/features/authentication/screens/guarantor_info.dart';
import 'package:ojembaa_courier/features/authentication/screens/ownership_proof.dart';
import 'package:ojembaa_courier/features/authentication/screens/signup_page.dart';
import 'package:ojembaa_courier/features/authentication/screens/upload_picture.dart';
import 'package:ojembaa_courier/features/homepage/providers/get_location_provider.dart';
import 'package:ojembaa_courier/features/homepage/providers/get_requests_provider.dart';
import 'package:ojembaa_courier/features/homepage/screens/nav_page.dart';
import 'package:ojembaa_courier/features/payments/providers/get_transactions_provider.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';
import 'package:ojembaa_courier/utils/components/validators.dart';
import 'package:ojembaa_courier/utils/helpers/storage/storage_helper.dart';
import 'package:ojembaa_courier/utils/helpers/storage/storage_keys.dart';
import 'package:ojembaa_courier/utils/widgets/custom_button.dart';
import 'package:ojembaa_courier/utils/widgets/custom_textfield.dart';
import 'package:ojembaa_courier/utils/widgets/snackbar.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController emailController =
      TextEditingController(text: "aaifeanyi17@gmail.com");
  final TextEditingController passwordController =
      TextEditingController(text: "Password@1");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width(.06)),
              child: Form(
                key: _formKey,
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
                      validator: Validators.multipleAnd(
                          [Validators.email(), Validators.notEmpty()]),
                      hintText: "Email",
                      prefix: Container(
                        margin: EdgeInsets.only(
                            left: context.width(.06),
                            right: context.width(.03)),
                        child: SvgPicture.asset(
                          ImageUtil.email,
                        ),
                      ),
                    ),
                    SizedBox(height: context.height(.03)),
                    CustomTextFormField(
                      controller: passwordController,
                      hintText: "Password",
                      obscureText: obscure,
                      validator: Validators.notEmpty(),
                      prefix: Container(
                        margin: EdgeInsets.only(
                            left: context.width(.06),
                            right: context.width(.03)),
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
                    SizedBox(height: context.height(.025)),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPassword(),
                            ));
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Forgot your password?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: context.width(.04),
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    SizedBox(height: context.height(.01)),
                    Consumer(
                      builder: (context, ref, child) {
                        final watcher = ref.watch(signInProvider);
                        final reader = ref.read(signInProvider.notifier);
                        return CustomContinueButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              reader.signIn(
                                  onError: (p0) =>
                                      CustomSnackbar.showErrorSnackBar(context,
                                          message: p0),
                                  onSuccess: (user) {
                                    StorageHelper.setString(
                                        StorageKeys.userId, user.id);
                                    ref.read(userProvider.notifier).getDetails(
                                          onError: (p0) =>
                                              CustomSnackbar.showErrorSnackBar(
                                                  context,
                                                  message: p0),
                                          onSuccess: (p0) {
                                            if (user.profilePhoto == null) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const UploadPicture(),
                                                  ));
                                              return;
                                            }

                                            if (user.tools == null) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const OwnershipProof(),
                                                  ));
                                              return;
                                            }
                                            if (user.bankInformation == null ||
                                                user.bankInformation!.isEmpty) {
                                              ref
                                                  .read(
                                                      getBanksProvider.notifier)
                                                  .getBanks();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const EnterBankDetails(),
                                                  ));
                                              return;
                                            }
                                            if (user.guarantor == null ||
                                                user.bankInformation!.isEmpty) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const GuarantorInfo(),
                                                  ));
                                              return;
                                            }
                                            ref
                                                .read(getLocationProvider
                                                    .notifier)
                                                .getCurrentLocation();
                                            ref
                                                .read(getRequestsProvider
                                                    .notifier)
                                                .getRequests();
                                            ref
                                                .read(getTransactionsProvider
                                                    .notifier)
                                                .getTransactions(user.id!);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  settings: const RouteSettings(
                                                      name: "/mainPage"),
                                                  builder: (context) =>
                                                      const NavPage(),
                                                ));
                                          },
                                        );
                                  },
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim());
                            }
                          },
                          isActive: !watcher.isLoading,
                          sidePadding: 0,
                          elevation: 0,
                          bgColor: AppColors.accent,
                          title: "Sign In",
                        );
                      },
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
