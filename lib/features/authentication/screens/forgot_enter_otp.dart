import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_courier/features/authentication/providers/forgot_provider.dart';
import 'package:ojembaa_courier/features/authentication/screens/reset_password.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';
import 'package:ojembaa_courier/utils/widgets/custom_appbar.dart';
import 'package:ojembaa_courier/utils/widgets/custom_button.dart';
import 'package:ojembaa_courier/utils/widgets/pincode_field.dart';
import 'package:ojembaa_courier/utils/widgets/snackbar.dart';
import 'package:ojembaa_courier/utils/widgets/white_pill.dart';

class ForgotEnterOTP extends ConsumerStatefulWidget {
  final String email;
  const ForgotEnterOTP(this.email, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EnterOTPState();
}

class _EnterOTPState extends ConsumerState<ForgotEnterOTP> {
  final TextEditingController otpController = TextEditingController();

  bool enableResend = false;

  Timer? timer;
  Duration myDuration = const Duration(minutes: 5);

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  // Step 4
  void stopTimer() {
    setState(() => timer!.cancel());
  }

  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = const Duration(minutes: 5));
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 10) {
        enableResend = true;
      }
      if (seconds < 1) {
        timer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white_background,
      appBar: const CustomAppBar(
        bgColor: AppColors.white_background,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width(.06)),
          child: Column(
            children: [
              SvgPicture.asset(
                ImageUtil.main_icon_light,
                height: context.height(.06),
              ),
              SizedBox(height: context.height(.04)),
              Text(
                "Enter verification code",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: context.width(.05),
                    color: AppColors.accent,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: context.height(.015)),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: "We sent you a"),
                    const TextSpan(
                        text: " One Time Password\n",
                        style: TextStyle(fontWeight: FontWeight.w700)),
                    const TextSpan(text: "on this email"),
                    TextSpan(
                        text: " ${widget.email}",
                        style: const TextStyle(fontWeight: FontWeight.w700))
                  ],
                  style: TextStyle(
                    fontSize: context.width(.037),
                    color: AppColors.accent,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.height(.03)),
              enableResend
                  ? Consumer(builder: (context, ref, child) {
                      final reader = ref.read(forgotProvider.notifier);
                      return InkWell(
                        onTap: () {
                          reader.forgotPass(
                            email: widget.email,
                            onError: (p0) {
                              CustomSnackbar.showErrorSnackBar(context,
                                  message: p0);
                            },
                            onSuccess: () {
                              setState(() {
                                resetTimer();
                                startTimer();
                                enableResend = false;
                              });
                              CustomSnackbar.showSuccessSnackBar(context,
                                  message: "OTP sent successfully");
                            },
                          );
                        },
                        child: WhitePill(
                          color: const Color(0xffF4F2EA),
                          padding: EdgeInsets.symmetric(
                              horizontal: context.width(.04),
                              vertical: context.height(.012)),
                          child: Text("Resend",
                              style: TextStyle(
                                fontSize: context.width(.038),
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary,
                              )),
                        ),
                      );
                    })
                  : Text.rich(
                      TextSpan(
                        style: TextStyle(
                            color: AppColors.accent.withOpacity(.7),
                            fontSize: context.width(.038),
                            fontWeight: FontWeight.w400),
                        children: [
                          const TextSpan(text: "Resend Code in "),
                          TextSpan(
                              text:
                                  "${myDuration.inMinutes.remainder(60).toString().timeDigits()}:${myDuration.inSeconds.remainder(60).toString().timeDigits()}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700))
                        ],
                      ),
                    ),
              SizedBox(height: context.height(.05)),
              PinTextField(
                controller: otpController,
                length: 4,
              ),
              SizedBox(height: context.height(.05)),
              CustomContinueButton(
                sidePadding: 0,
                onPressed: () {
                  if (otpController.text.isNotEmpty) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPassword(
                              otpController.text.trim(), widget.email),
                        ));
                  } else {
                    CustomSnackbar.showErrorSnackBar(context,
                        message: "Please enter the OTP");
                  }
                },
                bgColor: AppColors.accent,
                disabledBgColor: AppColors.hintColor.withOpacity(.5),
              )
            ],
          ),
        ),
      ),
    );
  }
}
