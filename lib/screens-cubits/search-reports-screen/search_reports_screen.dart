// ignore_for_file: avoid_print

import 'package:capef/global_cubits/reports_cubit/general_reports_cubit.dart';
import 'package:capef/screens-cubits/search-reports-screen/search_reports_body.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/functions.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SearchReportsScreen extends StatefulWidget {
  SearchReportsScreen({super.key, required this.from, required this.to});

  DateTime? from;
  DateTime? to;

  @override
  State<SearchReportsScreen> createState() => _SearchReportsScreenState();
}

class _SearchReportsScreenState extends State<SearchReportsScreen> {
  @override
  void initState() {
    print(DateTime.now().toString());
    context.read<GetReportsCubit>().getGeneralReports(
        jwttoken: GlobalFunctions.getLocalJWTToken(),
        fromDate: widget.from.toString().substring(0, 10),
        toDate: widget.to.toString().substring(0, 10));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: BlocBuilder<GetReportsCubit, ReportsState>(
          builder: (context, state) {
            if (state is GetReportsLoading) {
              return const Scaffold(
                appBar: BuildAppBar(title: 'Rapports'),
                body: Center(
                    child: CircularProgressIndicator(
                        color: GlobalColors.mainGreenColor)),
              );
            }
            if (state is GetReportsFailure) {
              return const Center(
                child: Text('Try Again',
                    style: GlobalTextStyles.underlinedTextButton),
              );
            }
            if (state is GetReportsSuccess) {
              return Scaffold(
                appBar: const BuildAppBar(title: 'Rapports'),
                body: SearchReportsBody(
                    from: widget.from,
                    to: widget.to,
                    getGeneralReportsModel: state.generalReportsModel),
              );
            }
            return Scaffold(
              appBar: const BuildAppBar(title: 'Rapports'),
              body: SearchReportsBody(
                  from: widget.from,
                  to: widget.to,
                  getGeneralReportsModel: null),
            );
          },
        ));
  }
}
