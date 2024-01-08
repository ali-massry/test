// ignore_for_file: avoid_print
import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/screens-cubits/group-flow-screens/step-1/group_step_1_screen.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-1/physical_person_step_1_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:capef/assets.dart';
import 'package:capef/global_cubits/activities_cubit/activities_cubit.dart';
import 'package:capef/models/detailed_member_model.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/repositories/member_repo/member_repository.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/agri-flow-screens/cubit/agri_cubit.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/cubit/breeding_cubit.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/cubit/fishing_cubit.dart';
import 'package:capef/screens-cubits/forest-flow-screens/cubit/forest_cubit.dart';
import 'package:capef/screens-cubits/group-flow-screens/step-2/group_step_2_screen.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-2/step_2_model.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-3/physical_person_step_3_screen.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/functions.dart';
import 'package:capef/utils/svg_builder.dart';
import 'package:capef/widgets/image_network.dart';
import 'package:flutter/material.dart';

class BuildPersonalInfromation extends StatelessWidget {
  const BuildPersonalInfromation(
      {super.key, required this.detailedMemberModel});
  final DetailedMemberModel? detailedMemberModel;

  @override
  Widget build(BuildContext context) {
    String? onlineId = detailedMemberModel?.onlineid;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: mqh(context, 20)),
          detailedMemberModel?.membertypeid == 2
              ? BuildHeaderLegalEntity(detailedMemberModel: detailedMemberModel)
              : BuildHeaderIndividual(detailedMemberModel: detailedMemberModel),
          GestureDetector(
            onTap: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return const CustomLoaderWidget();
                },
              );
              // GlobalFunctions.showLoader(context);
              DetailedMemberModel detailedMemberModel =
                  await MemberRepository.getMemberById(
                      jwttoken: GlobalFunctions.getLocalJWTToken(),
                      memberId: onlineId ?? '');

              print(detailedMemberModel);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);

              // ignore: use_build_context_synchronously
              Navigator.of(context).pushNamed(
                  detailedMemberModel.membertypeid != 2
                      ? Routes.addPhysicalPersonScreen3
                      : Routes.addgroupScreen2,
                  arguments: detailedMemberModel.membertypeid != 2
                      ? AddPhysicalPersonStep3Screen(
                          detailedMemberModel: detailedMemberModel,
                          addPhysicalMemberStep2Model:
                              PersonalInfoWithPhotoModel(
                                  addPhysicalMemberStep1Model: null,
                                  nationalPhoto: null,
                                  rectoPhoto: null,
                                  versoPhoto: null),
                        )
                      : AddGroupStep2Screen(
                          detailedMemberModel: detailedMemberModel));
            },
            child: BuildEditContainer(
              title: 'Lieu De Résidence',
              contect:
                  '${detailedMemberModel?.region}, ${detailedMemberModel?.district}, ${detailedMemberModel?.area}, ${detailedMemberModel?.village}, ${detailedMemberModel?.individualmember?.email}',
            ),
          ),
          SizedBox(height: mqh(context, 10)),
          detailedMemberModel?.maincategory == null
              ? const SizedBox()
              : GestureDetector(
                  onTap:
                      // detailedMemberModel?.membertypeid != 2

                      //     ?
                      () {
                    context.read<ActivitiesCubit>().secondaryActivityId = null;

                    print(context.read<ActivitiesCubit>().secondaryActivityId);
                    // print('object');
                    if (detailedMemberModel?.maincategoryid == 1) {
                      context.read<AgriCubit>().fromProfileEdit =
                          detailedMemberModel?.agri?[0].membercatid.toString();
                      context.read<AgriCubit>().offOnId =
                          detailedMemberModel?.onlineid;

                      Navigator.of(context).pushNamed(Routes.agriStep1Screen);
                    } else if (detailedMemberModel?.maincategoryid == 2) {
                      context.read<FishingCubit>().fromProfileEdit =
                          detailedMemberModel?.fishing?[0].membercatid
                              .toString();
                      context.read<FishingCubit>().offOnId =
                          detailedMemberModel?.onlineid;
                      Navigator.of(context)
                          .pushNamed(Routes.fishingStep1Screen);
                    } else if (detailedMemberModel?.maincategoryid == 3) {
                      context.read<BreedingCubit>().fromProfileEdit =
                          detailedMemberModel?.breedingDetail?[0].membercatid
                              .toString();
                      context.read<BreedingCubit>().offonId =
                          detailedMemberModel?.onlineid;
                      Navigator.of(context)
                          .pushNamed(Routes.breedingStep1Screen);
                    } else if (detailedMemberModel?.maincategoryid == 4) {
                      context.read<ForestCubit>().fromProfileEdit =
                          detailedMemberModel?.forests?[0].membercatid
                              .toString();
                      context.read<ForestCubit>().offOnId =
                          detailedMemberModel?.onlineid;
                      Navigator.of(context).pushNamed(Routes.forestStep1Screen);
                    }
                  }
                  // : () {
                  // print('object ajs');
                  // if (detailedMemberModel?.secondarycategoryid == 1) {
                  //   context.read<AgriCubit>().fromProfileEdit == 'a';
                  //   Navigator.of(context)
                  //       .pushNamed(Routes.agriStep1Screen);
                  // } else if (detailedMemberModel?.secondarycategoryid ==
                  //     2) {
                  //   context.read<FishingCubit>().fromProfileEdit == 'a';
                  //   Navigator.of(context)
                  //       .pushNamed(Routes.fishingStep1Screen);
                  // } else if (detailedMemberModel?.secondarycategoryid ==
                  //     3) {
                  //   context.read<BreedingCubit>().fromProfileEdit ==
                  //       'a';
                  //   Navigator.of(context)
                  //       .pushNamed(Routes.breedingStep1Screen);
                  // } else if (detailedMemberModel?.secondarycategoryid ==
                  //     4) {
                  //   context.read<ForestCubit>().fromProfileEdit == 'a';
                  //   Navigator.of(context)
                  //       .pushNamed(Routes.forestStep1Screen);
                  // }
                  // }
                  ,
                  child: BuildEditContainer(
                    title: 'Activité Principale',
                    contect: detailedMemberModel?.maincategory,
                  ),
                ),
          SizedBox(height: mqh(context, 10)),
          detailedMemberModel?.secondarycategory == null
              ? const SizedBox()
              : GestureDetector(
                  onTap: () {
                    context.read<ActivitiesCubit>().secondaryActivityId = null;
                    print(context.read<ActivitiesCubit>().secondaryActivityId);

                    // print('object ajs');
                    if (detailedMemberModel?.secondarycategoryid == 1) {
                      context.read<AgriCubit>().fromProfileEdit =
                          detailedMemberModel?.agri?[0].membercatid.toString();
                      context.read<AgriCubit>().offOnId =
                          detailedMemberModel?.onlineid;
                      Navigator.of(context).pushNamed(Routes.agriStep1Screen);
                    } else if (detailedMemberModel?.secondarycategoryid == 2) {
                      context.read<FishingCubit>().fromProfileEdit =
                          detailedMemberModel?.fishing?[0].membercatid
                              .toString();
                      context.read<FishingCubit>().offOnId =
                          detailedMemberModel?.onlineid;
                      Navigator.of(context)
                          .pushNamed(Routes.fishingStep1Screen);
                    } else if (detailedMemberModel?.secondarycategoryid == 3) {
                      context.read<BreedingCubit>().fromProfileEdit =
                          detailedMemberModel?.breedingDetail?[0].membercatid
                              .toString();
                      context.read<BreedingCubit>().offonId =
                          detailedMemberModel?.onlineid;
                      Navigator.of(context)
                          .pushNamed(Routes.breedingStep1Screen);
                    } else if (detailedMemberModel?.secondarycategoryid == 4) {
                      context.read<ForestCubit>().fromProfileEdit =
                          detailedMemberModel?.forests?[0].membercatid
                              .toString();
                      context.read<ForestCubit>().offOnId =
                          detailedMemberModel?.onlineid;
                      Navigator.of(context).pushNamed(Routes.forestStep1Screen);
                    }
                  },
                  child: BuildEditContainer(
                    title: 'Activité Secondaire',
                    contect: detailedMemberModel?.secondarycategory,
                  ),
                ),
          SizedBox(height: mqh(context, 40)),
        ],
      ),
    );
  }
}

class BuildEditContainer extends StatelessWidget {
  const BuildEditContainer(
      {super.key, required this.title, required this.contect});
  final String? title;
  final String? contect;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title ?? '',
                        style: GlobalTextStyles.ts15montboldBlack),
                    SizedBox(height: mqh(context, 15)),
                    Text(contect ?? '',
                        style: GlobalTextStyles.ts13montsemiBold30OpaquBlack),
                  ],
                ),
              ),
              Center(
                child: Container(
                  width: mqw(context, 37),
                  height: mqh(context, 37),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: GlobalColors.mainGreenColor.withOpacity(0.1)),
                  child: Center(
                    child: SvgBuilder(asset: Assets.icons.editSvg),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildHeaderIndividual extends StatelessWidget {
  const BuildHeaderIndividual({super.key, this.detailedMemberModel});
  final DetailedMemberModel? detailedMemberModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipOval(
            child: BuildImageNetwork(
          detailedMemberModel?.membertypeid == 2
              ? detailedMemberModel?.legalentitymember?.photocertificate
              : detailedMemberModel?.individualmember?.photomember,
          width: mqw(context, 135),
          height: mqh(context, 135),
          fit: BoxFit.cover,
        )),
        SizedBox(height: mqh(context, 20)),
        Text(
            detailedMemberModel?.membertypeid == 2
                ? detailedMemberModel!.legalentitymember!.name!
                : '${detailedMemberModel?.individualmember?.firstname} ${detailedMemberModel?.individualmember?.lastname}',
            style: GlobalTextStyles.ts20montboldBlack),
        SizedBox(height: mqh(context, 10)),
        Text(
            '${detailedMemberModel?.village} / ${detailedMemberModel?.area} / ${detailedMemberModel?.maincategory}',
            style: GlobalTextStyles.ts13montsemiBoldBlackWith40Opacity),
        SizedBox(height: mqh(context, 30)),
        Text('ID: ${detailedMemberModel?.onlineid}',
            style: GlobalTextStyles.ts13montboldGreen),
        SizedBox(height: mqh(context, 30)),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 80),
          // width: mqw(context, 137),
          height: 30,
          decoration: BoxDecoration(
            color: GlobalColors.goldColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: mqw(context, 34)),
          child: Center(
            child: Text(
              detailedMemberModel?.memberstatus?.toUpperCase() ?? '',
              style: const TextStyle(
                  color: GlobalColors.goldColor,
                  fontFamily: GlobalFonts.montserratBold,
                  fontSize: 12),
            ),
          ),
        ),
        SizedBox(height: mqh(context, 50)),
        const Text(
          'Informations Personnelles',
          style: TextStyle(
              fontSize: 18,
              color: GlobalColors.mainGreenColor,
              fontFamily: GlobalFonts.montserratBold),
        ),
        SizedBox(height: mqh(context, 25)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Sexe'.toUpperCase(),
              style: GlobalTextStyles.ts14montbold50OpaqueBlack,
            ),
            Text(
              detailedMemberModel?.individualmember?.gender ?? '',
              style: GlobalTextStyles.ts14montboldGreen,
            ),
          ],
        ),
        SizedBox(height: mqh(context, 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date de Naissance'.toUpperCase(),
              style: GlobalTextStyles.ts14montbold50OpaqueBlack,
            ),
            Text(
              detailedMemberModel?.individualmember?.dob ?? '',
              style: GlobalTextStyles.ts14montboldGreen,
            ),
          ],
        ),
        SizedBox(height: mqh(context, 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Lieu de Naissance'.toUpperCase(),
              style: GlobalTextStyles.ts14montbold50OpaqueBlack,
            ),
            Text(detailedMemberModel?.region ?? '',
                style: GlobalTextStyles.ts14montboldGreen),
          ],
        ),
        SizedBox(height: mqh(context, 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'téléphone'.toUpperCase(),
              style: GlobalTextStyles.ts14montbold50OpaqueBlack,
            ),
            Text(
              detailedMemberModel?.membertypeid == 2
                  ? detailedMemberModel?.legalentitymember?.telephone1 ?? ''
                  : detailedMemberModel?.individualmember?.telephone1 ?? '',
              style: GlobalTextStyles.ts14montboldGreen,
            ),
          ],
        ),
        SizedBox(height: mqh(context, 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'CNi'.toUpperCase(),
              style: GlobalTextStyles.ts14montbold50OpaqueBlack,
            ),
            Text(
              detailedMemberModel?.individualmember?.cni ?? '',
              style: GlobalTextStyles.ts14montboldGreen,
            ),
          ],
        ),
        SizedBox(height: mqh(context, 25)),
        detailedMemberModel?.membertypeid == 2
            ? const SizedBox()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BuildImageNetwork(
                            detailedMemberModel?.individualmember?.photofront ??
                                '',
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: mqh(context, 95),
                            borderRadius: BorderRadius.circular(10),
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: mqh(context, 12)),
                          const Text(
                            'Recto',
                            style: GlobalTextStyles.ts15montboldBlack,
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BuildImageNetwork(
                            detailedMemberModel?.individualmember?.photoback ??
                                '',
                            width: MediaQuery.of(context).size.width * 0.35,
                            borderRadius: BorderRadius.circular(10),
                            height: mqh(context, 95),
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: mqh(context, 12)),
                          const Text(
                            'Verso',
                            style: GlobalTextStyles.ts15montboldBlack,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
        SizedBox(height: mqh(context, 30)),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.addPhysicalPersonScreen1,
                arguments: AddPhysicalPersonStep1Screen(
                    detailedMemberModel: detailedMemberModel));
          },
          child: Text(
            'Modifier informations personnelles'.toUpperCase(),
            style: GlobalTextStyles.ts12underlineGreenBold,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: mqh(context, 50)),
      ],
    );
  }
}

class BuildHeaderLegalEntity extends StatefulWidget {
  const BuildHeaderLegalEntity({super.key, this.detailedMemberModel});
  final DetailedMemberModel? detailedMemberModel;

  @override
  State<BuildHeaderLegalEntity> createState() => _BuildHeaderLegalEntityState();
}

class _BuildHeaderLegalEntityState extends State<BuildHeaderLegalEntity> {
  Civilities getCivilityFromId() {
    for (var element in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .civilities!) {
      if (element.id ==
          widget.detailedMemberModel?.legalentitymember?.representatives?[0]
              .civilityid) {
        return element;
      }
    }
    return Civilities();
  }

  Titles getTitleFromId() {
    for (var element
        in context.read<GetOfflineCubitCubit>().getOfflineDataModel!.titles!) {
      if (element.id ==
          widget.detailedMemberModel?.legalentitymember?.representatives?[0]
              .titleid) {
        return element;
      }
    }
    return Titles();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ClipOval(
        //     child: BuildImageNetwork(
        //   detailedMemberModel?.membertypeid == 2
        //       ? detailedMemberModel?.legalentitymember?.photocertificate
        //       : detailedMemberModel?.individualmember?.photomember,
        //   width: mqw(context, 135),
        //   height: mqh(context, 135),
        //   fit: BoxFit.cover,
        // )),
        // SizedBox(height: mqh(context, 20)),
        Text(widget.detailedMemberModel!.legalentitymember!.name!,
            style: GlobalTextStyles.ts20montboldBlack),
        SizedBox(height: mqh(context, 10)),
        Text(
            '${widget.detailedMemberModel?.village} / ${widget.detailedMemberModel?.area} / ${widget.detailedMemberModel?.maincategory}',
            style: GlobalTextStyles.ts13montsemiBoldBlackWith40Opacity),
        SizedBox(height: mqh(context, 30)),
        Text('ID: ${widget.detailedMemberModel?.onlineid}',
            style: GlobalTextStyles.ts13montboldGreen),
        SizedBox(height: mqh(context, 30)),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 80),
          // width: mqw(context, 137),
          height: 30,
          decoration: BoxDecoration(
            color: GlobalColors.goldColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: mqw(context, 34)),
          child: Center(
            child: Text(
              widget.detailedMemberModel?.memberstatus?.toUpperCase() ?? '',
              style: const TextStyle(
                  color: GlobalColors.goldColor,
                  fontFamily: GlobalFonts.montserratBold,
                  fontSize: 12),
            ),
          ),
        ),
        SizedBox(height: mqh(context, 50)),
        const Text(
          'Informations Générales',
          style: TextStyle(
              fontSize: 18,
              color: GlobalColors.mainGreenColor,
              fontFamily: GlobalFonts.montserratBold),
        ),
        SizedBox(height: mqh(context, 25)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date certificat d’inscription'.toUpperCase(),
              style: GlobalTextStyles.ts14montbold50OpaqueBlack,
            ),
            Text(
              widget.detailedMemberModel?.legalentitymember?.certdate ?? '',
              style: GlobalTextStyles.ts14montboldGreen,
            ),
          ],
        ),
        SizedBox(height: mqh(context, 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Chiffre D’Affaires'.toUpperCase(),
              style: GlobalTextStyles.ts14montbold50OpaqueBlack,
            ),
            Text(
              widget.detailedMemberModel?.legalentitymember?.turnover ?? '',
              style: GlobalTextStyles.ts14montboldGreen,
            ),
          ],
        ),
        SizedBox(height: mqh(context, 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'téléphone 1'.toUpperCase(),
              style: GlobalTextStyles.ts14montbold50OpaqueBlack,
            ),
            Text(
                widget.detailedMemberModel?.legalentitymember?.telephone1 ?? '',
                style: GlobalTextStyles.ts14montboldGreen),
          ],
        ),
        SizedBox(height: mqh(context, 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'téléphone 2'.toUpperCase(),
              style: GlobalTextStyles.ts14montbold50OpaqueBlack,
            ),
            Text(
              widget.detailedMemberModel?.legalentitymember?.telephone2 ?? '',
              style: GlobalTextStyles.ts14montboldGreen,
            ),
          ],
        ),
        SizedBox(height: mqh(context, 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Email'.toUpperCase(),
              style: GlobalTextStyles.ts14montbold50OpaqueBlack,
            ),
            Text(
              widget.detailedMemberModel?.legalentitymember?.email ?? '',
              style: GlobalTextStyles.ts14montboldGreen,
            ),
          ],
        ),
        SizedBox(height: mqh(context, 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Nb de RESSORTISSANTS'.toUpperCase(),
              style: GlobalTextStyles.ts14montbold50OpaqueBlack,
            ),
            Text(
              widget.detailedMemberModel?.legalentitymember?.numberofmembers ??
                  '',
              style: GlobalTextStyles.ts14montboldGreen,
            ),
          ],
        ),
        SizedBox(height: mqh(context, 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dont femmes'.toUpperCase(),
              style: GlobalTextStyles.ts14montbold50OpaqueBlack,
            ),
            Text(
              widget.detailedMemberModel?.legalentitymember?.women ?? '',
              style: GlobalTextStyles.ts14montboldGreen,
            ),
          ],
        ),
        SizedBox(height: mqh(context, 25)),
        Card(
          color: Colors.white,
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BuildImageNetwork(
                  widget
                      .detailedMemberModel?.legalentitymember?.photocertificate,
                  width: MediaQuery.of(context).size.width * 1,
                  borderRadius: BorderRadius.circular(10),
                  height: mqh(context, 150),
                  fit: BoxFit.cover,
                ),
                SizedBox(height: mqh(context, 12)),
                const Text(
                  'Certificat D’inscription',
                  style: GlobalTextStyles.ts15montboldBlack,
                )
              ],
            ),
          ),
        ),

        SizedBox(height: mqh(context, 60)),
        const Text(
          '1er Représentant',
          style: TextStyle(
              fontSize: 18,
              color: GlobalColors.mainGreenColor,
              fontFamily: GlobalFonts.montserratBold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Civilité'.toUpperCase(),
              style: GlobalTextStyles.ts14montbold50OpaqueBlack,
            ),
            Text(
              getCivilityFromId().name ?? '',
              style: GlobalTextStyles.ts14montboldGreen,
            ),
          ],
        ),
        SizedBox(height: mqh(context, 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'prénom'.toUpperCase(),
              style: GlobalTextStyles.ts14montbold50OpaqueBlack,
            ),
            Text(
              widget.detailedMemberModel?.legalentitymember?.representatives?[0]
                      .firstname ??
                  '',
              style: GlobalTextStyles.ts14montboldGreen,
            ),
          ],
        ),
        SizedBox(height: mqh(context, 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'NOM'.toUpperCase(),
              style: GlobalTextStyles.ts14montbold50OpaqueBlack,
            ),
            Text(
                widget.detailedMemberModel?.legalentitymember
                        ?.representatives?[0].lastname ??
                    '',
                style: GlobalTextStyles.ts14montboldGreen),
          ],
        ),
        SizedBox(height: mqh(context, 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Titre'.toUpperCase(),
              style: GlobalTextStyles.ts14montbold50OpaqueBlack,
            ),
            Text(
              getTitleFromId().name ?? '',
              style: GlobalTextStyles.ts14montboldGreen,
            ),
          ],
        ),
        SizedBox(height: mqh(context, 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'téléphone 1'.toUpperCase(),
              style: GlobalTextStyles.ts14montbold50OpaqueBlack,
            ),
            Text(
              widget.detailedMemberModel?.legalentitymember?.representatives?[0]
                      .phonenumber ??
                  '',
              style: GlobalTextStyles.ts14montboldGreen,
            ),
          ],
        ),
        SizedBox(height: mqh(context, 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Email'.toUpperCase(),
              style: GlobalTextStyles.ts14montbold50OpaqueBlack,
            ),
            Text(
              widget.detailedMemberModel?.legalentitymember?.representatives?[0]
                      .email ??
                  '',
              style: GlobalTextStyles.ts14montboldGreen,
            ),
          ],
        ),
        SizedBox(height: mqh(context, 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Adresse'.toUpperCase(),
              style: GlobalTextStyles.ts14montbold50OpaqueBlack,
            ),
            Text(
              widget.detailedMemberModel?.legalentitymember?.representatives?[0]
                      .address ??
                  '',
              style: GlobalTextStyles.ts14montboldGreen,
            ),
          ],
        ),
        // SizedBox(height: mqh(context, 25)),

        SizedBox(height: mqh(context, 30)),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.addgroupScreen1,
                arguments: AddGroupStep1Screen(
                    detailedMemberModel: widget.detailedMemberModel));
          },
          child: Text(
            'Modifier informations Générales'.toUpperCase(),
            style: GlobalTextStyles.ts12underlineGreenBold,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: mqh(context, 50)),
      ],
    );
  }
}
