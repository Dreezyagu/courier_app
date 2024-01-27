import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/deliveries/widgets/deliveries_list.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';

class DeliveriesPage extends ConsumerWidget {
  const DeliveriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.width(.06)),
        child: Column(
          children: [
            SizedBox(height: context.height(.03)),
            const DeliveriesList(),
          ],
        ),
      )),
    );
  }
}
