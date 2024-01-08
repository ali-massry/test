import 'package:capef/screens-cubits/reports-screen/reports_body.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        top: true,
        child: Scaffold(
          appBar: BuildAppBar(title: 'Page D’accueil'),
          body: ReportsBody(),
        ));
  }
}
