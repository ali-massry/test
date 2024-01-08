// ignore_for_file: avoid_print

import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/search-reports-screen/search_reports_screen.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/label_with_date_picker.dart';
import 'package:flutter/widgets.dart';

class ReportsBody extends StatefulWidget {
  const ReportsBody({super.key});

  @override
  State<ReportsBody> createState() => _ReportsBodyState();
}

class _ReportsBodyState extends State<ReportsBody> {
  DateTime? from;
  DateTime? to;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: globalScreenPaddings,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(height: mqh(context, 40)),
              const Text(
                'RECHERCHER Les Rapports Par Dates',
                style: GlobalTextStyles.ts20montboldGreen,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: mqh(context, 40)),
              BuildLabelWithDatePicker(
                label: 'Date « Du »',
                dateTime: DateTime.now(),
                onDateSelected: (p0) {
                  from = p0;
                  print('From $p0');
                },
              ),
              SizedBox(height: mqh(context, 20)),
              BuildLabelWithDatePicker(
                label: 'Date « Au »',
                dateTime: DateTime.now(),
                onDateSelected: (p0) {
                  to = p0;
                  print('To $p0');
                },
              ),
            ],
          ),
          BuildButton(
            onTap: () {
              if (from == null || to == null) {
                GlobalSnackbar.showFailureToast(
                    context, 'Assurez-vous de sélectionner les dates');
              } else {
                Navigator.of(context).pushNamed(Routes.searchReportsScreen,
                    arguments: SearchReportsScreen(from: from, to: to));
                print('From $from - To $to');
              }
            },
            txt: 'SUBMIT',
          )
        ],
      ),
    );
  }
}
