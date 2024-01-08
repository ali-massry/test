import 'package:capef/global_cubits/reports_cubit/detailed_reports_cubit.dart';
import 'package:capef/global_cubits/reports_cubit/detailed_reports_state.dart';
import 'package:capef/screens-cubits/detailed-reports-screen/detailed_reports_body.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/functions.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailedReportsScreen extends StatefulWidget {
  const DetailedReportsScreen(
      {super.key,
      required this.title,
      required this.categoryId,
      required this.from,
      required this.to});
  final String? title;
  final int categoryId;
  final String? from;
  final String? to;

  @override
  State<DetailedReportsScreen> createState() => _DetailedReportsScreenState();
}

class _DetailedReportsScreenState extends State<DetailedReportsScreen> {
  @override
  void initState() {
    context.read<DetailedReportsCubit>().getDetailedReports(
        jwttoken: GlobalFunctions.getLocalJWTToken(),
        fromDate: widget.from ?? '',
        toDate: widget.to ?? '',
        categoryId: widget.categoryId);
    // context.read<>()
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          appBar: BuildAppBar(title: widget.title),
          body: BlocBuilder<DetailedReportsCubit, DetailedReportsState>(
            builder: (context, state) {
              if (state is DetailedReportsLoading) {
                return const Center(
                    child: CircularProgressIndicator(
                        color: GlobalColors.mainGreenColor));
              }
              if (state is DetailedReportsSuccess) {
                return DetailedReportsBody(
                  getDetailedReportModel: state.getDetailedReportModel,
                  title: widget.title,
                  categoryId: widget.categoryId,
                );
              }
              return DetailedReportsBody(
                  title: widget.title, categoryId: widget.categoryId);
            },
          ),
        ));
  }
}
