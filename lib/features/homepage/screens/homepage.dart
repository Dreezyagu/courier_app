import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/homepage/widgets/courier_info_widget.dart';
import 'package:ojembaa_courier/features/homepage/widgets/homepage_deliveries_widget.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [HomepageDeliveriesWidget(), CourierInfoWidget()],
        ),
      ),
    );
  }
}
