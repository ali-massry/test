import 'package:capef/global_cubits/get_member_by_id/get_member_by_id_cubit.dart';
import 'package:capef/models/detailed_member_model.dart';
import 'package:capef/models/get_detailed_report_model.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/functions.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/widgets/member_personal_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailedReportsBody extends StatefulWidget {
  const DetailedReportsBody({
    super.key,
    this.getDetailedReportModel,
    required this.title,
    required this.categoryId,
  });
  final GetDetailedReportModel? getDetailedReportModel;
  final String? title;
  final int? categoryId;

  @override
  State<DetailedReportsBody> createState() => _DetailedReportsBodyState();
}

class _DetailedReportsBodyState extends State<DetailedReportsBody> {
  DateTime? from;
  DateTime? to;

  Future<void> showMemberProfileBottomSheet(BuildContext context,
      {required DetailedMemberModel? detailedMemberModel}) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // elevation: mqh(context, 310),
      builder: (context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: BuildPersonalInfromation(
                detailedMemberModel: detailedMemberModel));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: globalScreenPaddings,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: mqh(context, 40)),
            Text(
              'Rapports ${widget.title}',
              style: GlobalTextStyles.ts20montboldGreen,
            ),
            SizedBox(height: mqh(context, 5)),
            Text(
              '${widget.getDetailedReportModel?.fromdate?.replaceAll('-', '/')} - ${widget.getDetailedReportModel?.todate?.replaceAll('-', '/')}',
              style: GlobalTextStyles.ts20montboldGreen,
            ),
            SizedBox(height: mqh(context, 40)),
            Card(
              elevation: 5,
              child: Container(
                width: double.infinity,
                height: mqh(context, 100),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Rapports ${widget.getDetailedReportModel?.fromdate?.replaceAll('-', '/')} - ${widget.getDetailedReportModel?.todate?.replaceAll('-', '/')}',
                          style: GlobalTextStyles.ts14montbold50OpaqueBlack,
                        ),
                        SizedBox(height: mqh(context, 10)),
                        Text(
                          widget.getDetailedReportModel?.count.toString() ?? '',
                          style: TextStyle(
                            fontSize: 25,
                            color: widget.categoryId == 1
                                ? GlobalColors.lightGreenColor.withOpacity(0.1)
                                : widget.categoryId == 2
                                    ? GlobalColors.blueColor
                                    : widget.categoryId == 3
                                        ? GlobalColors.purpleColor
                                        : widget.categoryId == 4
                                            ? GlobalColors.mainGreenColor
                                            : GlobalColors.mainGreenColor,
                            fontFamily: GlobalFonts.montserratBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: mqh(context, 45)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  // height: 10,
                  width: MediaQuery.of(context).size.width * 0.2,

                  child: Text(
                    'Date'.toUpperCase(),
                    style: GlobalTextStyles.ts14montboldGreen,
                  ),
                ),
                SizedBox(
                  // height: 10,
                  width: MediaQuery.of(context).size.width * 0.2,

                  child: Text(
                    'id'.toUpperCase(),
                    style: GlobalTextStyles.ts14montboldGreen,
                  ),
                ),
                SizedBox(
                  // height: 10,
                  width: MediaQuery.of(context).size.width * 0.2,

                  child: Text(
                    'nom'.toUpperCase(),
                    style: GlobalTextStyles.ts14montboldGreen,
                  ),
                ),
                SizedBox(
                  // height: 10,
                  width: MediaQuery.of(context).size.width * 0.2,

                  child: Text(
                    'statut'.toUpperCase(),
                    style: GlobalTextStyles.ts14montboldGreen,
                  ),
                ),
                // Text(
                // 'Date'.toUpperCase(),
                // style: GlobalTextStyles.ts14montboldGreen,
                // ),
                // Text(
                //   'Id'.toUpperCase(),
                //   style: GlobalTextStyles.ts14montboldGreen,
                // ),
                // Text(
                //   'Nom'.toUpperCase(),
                //   style: GlobalTextStyles.ts14montboldGreen,
                // ),
                // Text(
                //   'Statut'.toUpperCase(),
                //   style: GlobalTextStyles.ts14montboldGreen,
                // ),
              ],
            ),
            SizedBox(height: mqh(context, 8)),
            const Divider(height: 5, color: GlobalColors.greyColor),
            BlocConsumer<GetMemberByIdCubit, GetMemberByIdState>(
              listener: (context, state) {
                if (state is GetMemberByIdSuccess) {
                  showMemberProfileBottomSheet(context,
                      detailedMemberModel: state.detailedMemberModel);
                } else if (state is GetMemberByIdFailure) {
                  GlobalSnackbar.showFailureToast(
                      context, state.status.message);
                }
              },
              builder: (context, state) {
                return ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          await context
                              .read<GetMemberByIdCubit>()
                              .getDetailedMember(
                                  jwttoken: GlobalFunctions.getLocalJWTToken(),
                                  memberId: widget.getDetailedReportModel
                                          ?.data?[index].onlineid ??
                                      '');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text(
                                widget.getDetailedReportModel?.data?[index]
                                        .datestr ??
                                    '',
                                style: GlobalTextStyles
                                    .ts13montsemiBold30OpaquBlack,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text(
                                widget.getDetailedReportModel?.data?[index]
                                        .onlineid ??
                                    '',
                                style: GlobalTextStyles
                                    .ts13montsemiBold30OpaquBlack,
                              ),
                            ),
                            // !FIX to be sent from rami
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text(
                                widget.getDetailedReportModel?.data?[index]
                                        .membername ??
                                    '',
                                style: GlobalTextStyles
                                    .ts13montsemiBold30OpaquBlack,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text(
                                widget.getDetailedReportModel?.data?[index]
                                        .status ??
                                    '',
                                style: GlobalTextStyles
                                    .ts13montsemiBold30OpaquBlack,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(height: mqh(context, 8)),
                          const Divider(
                              height: 5, color: GlobalColors.greyColor),
                        ],
                      );
                    },
                    itemCount:
                        widget.getDetailedReportModel?.data?.length ?? 0);
              },
            ),
          ]),
    );
  }
}
