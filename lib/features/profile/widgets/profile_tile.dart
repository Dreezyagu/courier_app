import 'package:flutter/material.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';

class ProfileTile extends StatelessWidget {
  final String title, subtitle;

  const ProfileTile({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.width(.02)),
      child: ListTile(
        tileColor: const Color(0xffF6F5F5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          title,
          style: TextStyle(
              color: const Color(0xff383C3E), fontSize: context.width(.04)),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
              color: const Color(0xff383C3E),
              fontWeight: FontWeight.w600,
              fontSize: context.width(.045)),
        ),
      ),
    );
  }
}
