import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ojembaa_courier/features/authentication/models/user_model.dart';
import 'package:ojembaa_courier/features/authentication/providers/get_banks_provider.dart';
import 'package:ojembaa_courier/features/authentication/providers/user_provider.dart';
import 'package:ojembaa_courier/features/authentication/screens/enter_bank_details.dart';
import 'package:ojembaa_courier/features/authentication/screens/guarantor_info.dart';
import 'package:ojembaa_courier/features/authentication/screens/login_page.dart';
import 'package:ojembaa_courier/features/authentication/screens/ownership_proof.dart';
import 'package:ojembaa_courier/features/authentication/screens/upload_picture.dart';
import 'package:ojembaa_courier/features/homepage/providers/get_location_provider.dart';
import 'package:ojembaa_courier/features/homepage/providers/get_requests_provider.dart';
import 'package:ojembaa_courier/features/homepage/screens/nav_page.dart';
import 'package:ojembaa_courier/features/payments/providers/get_balance_provider.dart';
import 'package:ojembaa_courier/features/payments/providers/get_transactions_provider.dart';
import 'package:ojembaa_courier/features/preliminary/screens/welcome_page.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';
import 'package:ojembaa_courier/utils/data_util/notifications_util.dart';
import 'package:ojembaa_courier/utils/helpers/storage/storage_helper.dart';
import 'package:ojembaa_courier/utils/helpers/storage/storage_keys.dart';
import 'package:ojembaa_courier/utils/widgets/snackbar.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    checkToken();
    super.initState();
  }

  checkToken() async {
    NotificationsUtil().setUpFirebaseMessaging(context);
    final values = await Future.wait([
      StorageHelper.getString(StorageKeys.accessToken),
      StorageHelper.getString(StorageKeys.userModelKey),
      StorageHelper.getBoolean(StorageKeys.rememberMeKey, false)
    ]);

    UserModel? user;
    if (values[1] != null) {
      user = UserModel.fromJson(values[1] as String);
    }
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (values.first != null && user != null && values.last == true) {
          StorageHelper.setString(StorageKeys.userId, user.id);
          ref.read(userProvider.notifier).getDetails(
            onError: (p0) {
              CustomSnackbar.showErrorSnackBar(context, message: p0);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomePage(),
                  ));
            },
            onSuccess: (p0) {
              if (p0.profilePhoto == null) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UploadPicture(),
                    ));
                return;
              }

              if (p0.tools == null) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OwnershipProof(),
                    ));
                return;
              }
              if (p0.bankInformation == null || p0.bankInformation!.isEmpty) {
                ref.read(getBanksProvider.notifier).getBanks();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EnterBankDetails(),
                    ));
                return;
              }
              if (p0.guarantor == null || p0.bankInformation!.isEmpty) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GuarantorInfo(),
                    ));
                return;
              }
              Future.wait([
                ref.read(getLocationProvider.notifier).getCurrentLocation(),
                ref.read(getRequestsProvider.notifier).getRequests(),
                ref
                    .read(getTransactionsProvider.notifier)
                    .getTransactions(p0.id!),
                ref.read(getBalanceProvider.notifier).getBalance()
              ]).then(
                (value) {
                  if (value.every((element) => element == true)) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          settings: const RouteSettings(name: "/mainPage"),
                          builder: (context) => const NavPage(),
                        ));
                  } else {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          settings: const RouteSettings(name: "/loginPage"),
                          builder: (context) => const LoginPage(),
                        ));
                  }
                },
              );
            },
          );
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WelcomePage(),
              ));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Positioned(
                top: context.height(.1),
                child: SvgPicture.asset(
                  ImageUtil.big_icon,
                  height: context.height(.92),
                ),
              ),
            ],
          ),
          SvgPicture.asset(ImageUtil.icon_title)
        ],
      ),
    );
  }
}
