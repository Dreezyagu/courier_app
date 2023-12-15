import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/authentication/widgets/create_account_widgets.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/widgets/custom_appbar.dart';
import 'package:ojembaa_courier/utils/widgets/custom_button.dart';
import 'package:ojembaa_courier/utils/widgets/white_pill.dart';

class ReconcilePage extends ConsumerStatefulWidget {
  const ReconcilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReconcilePageState();
}

class _ReconcilePageState extends ConsumerState<ReconcilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white_background,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.width(.06), vertical: context.width(.02)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pay into this account to reconcile this order.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.width(.04),
                color: AppColors.accent,
              ),
            ),
            SizedBox(height: context.width(.04)),
            WhitePill(
                width: double.infinity,
                color: const Color(0xffD9D9D9).withOpacity(.51),
                padding: EdgeInsets.symmetric(
                    horizontal: context.width(.06),
                    vertical: context.width(.04)),
                borderRadius: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextColumn(
                      title: "Bank",
                      subtitle: "Wema bank",
                    ),
                    SizedBox(height: context.width(.04)),
                    const TextColumn(
                      title: "Account name",
                      subtitle: "Ojembaa Logistic company",
                    ),
                    SizedBox(height: context.width(.04)),
                    const TextColumn(
                      title: "Account name",
                      subtitle: "826293200",
                    ),
                  ],
                )),
            SizedBox(height: context.width(.06)),
            Text(
              "Pay into this account to reconcile this order.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.width(.04),
                color: AppColors.accent,
              ),
            ),
            SizedBox(height: context.width(.02)),
            const AddPictureWidget(isLoading: false),
            SizedBox(height: context.width(.06)),
            CustomContinueButton(
              onPressed: () {},
              sidePadding: 0,
            )
          ],
        ),
      ),
    );
  }
}

class TextColumn extends StatelessWidget {
  const TextColumn({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: context.width(.04),
            fontWeight: FontWeight.w700,
            color: AppColors.accent,
          ),
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: context.width(.04),
            color: AppColors.accent,
          ),
        ),
      ],
    );
  }
}
