import 'package:flutter/material.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';

class CustomSnackbar {
  static void showSuccessSnackBar(BuildContext context,
      {required String message,
      int milliseconds = 3000,
      SnackBarBehavior snackBarBehavior = SnackBarBehavior.floating}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: AppColors.white,
          behavior: snackBarBehavior,
          elevation: 50,
          duration: Duration(milliseconds: milliseconds),
          dismissDirection: DismissDirection.down,
          content: SnackbarContent(title: "Success Alert", subtitle: message)),
    );
  }

  static void showErrorSnackBar(BuildContext context,
      {required String message,
      int milliseconds = 5000,
      SnackBarBehavior snackBarBehavior = SnackBarBehavior.floating}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.white,
        behavior: snackBarBehavior,
        elevation: 50,
        duration: Duration(milliseconds: milliseconds),
        dismissDirection: DismissDirection.down,
        content: SnackbarContent(
          subtitle: message,
          title: "Error Alert",
        ),
      ),
    );
  }

  static void dismissCurrentSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}

class SnackbarContent extends StatelessWidget {
  final String title;
  final String subtitle;

  const SnackbarContent({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: context.height(.01)),
        Text(
          title,
          style: TextStyle(
              color: title == "Error Alert" ? AppColors.red : AppColors.green,
              fontSize: context.width(.04),
              fontWeight: FontWeight.w600),
        ),
        SizedBox(height: context.height(.01)),
        Text(
          subtitle,
          style: TextStyle(
            color: AppColors.black,
            fontSize: context.width(.037),
          ),
        ),
      ],
    );
  }
}
