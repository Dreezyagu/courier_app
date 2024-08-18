import 'package:flutter/material.dart';
import 'package:ojembaa_courier/features/authentication/screens/login_page.dart';
import 'package:ojembaa_courier/utils/helpers/storage/storage_helper.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final bool? centerTitle;
  final bool automaticallyImplyLeading;
  final Color? bgColor;
  final VoidCallback? onTap;

  const CustomAppBar({
    Key? key,
    this.leading,
    this.title,
    this.centerTitle,
    this.automaticallyImplyLeading = true,
    this.bgColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading ??
          IconButton(
            onPressed: onTap ??
                () {
                  if (ModalRoute.of(context)?.isFirst ?? true) {
                    StorageHelper.clearPreferences();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          settings: const RouteSettings(name: "/loginPage"),
                          builder: (context) => const LoginPage(),
                        ));
                  } else {
                    Navigator.pop(context);
                  }
                },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
      backgroundColor: bgColor,
      title: title,
      centerTitle: centerTitle,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
