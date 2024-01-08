// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/global_cubits/location_cubit/location_cubit.dart';
import 'package:capef/global_cubits/physical_person_cubit/add_physical_person_cubit.dart';
import 'package:capef/global_cubits/update_legal_entity_member_cubit/update_legal_entity_member_cubit.dart';
import 'package:capef/models/detailed_member_model.dart';
import 'package:capef/models/legal_entity_info.dart';
import 'package:capef/repositories/member_repo/member_repository.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/group-flow-screens/cubit/group_flow_cubit.dart';
import 'package:capef/screens-cubits/national-detail-screen/national_detail_screen.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-1/personal_info.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/functions.dart';
import 'package:capef/utils/snackbar.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:capef/widgets/areas_drop_down.dart';
import 'package:capef/widgets/button.dart';
import 'package:capef/widgets/department_drop_down.dart';
import 'package:capef/widgets/easy_stepper.dart';
import 'package:capef/widgets/google_maps.dart';
import 'package:capef/widgets/label_with_textfield.dart';
import 'package:capef/widgets/region_drop_down.dart';
import 'package:capef/widgets/villages_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../../../models/offline_data_response.dart';

class AddGroupStep2Screen extends StatefulWidget {
  const AddGroupStep2Screen(
      {super.key, this.addPhysicalMemberStep1Model, this.detailedMemberModel});
  final PersonalInformationModel? addPhysicalMemberStep1Model;
  final DetailedMemberModel? detailedMemberModel;

  @override
  State<AddGroupStep2Screen> createState() => _AddGroupStep2ScreenState();
}

class _AddGroupStep2ScreenState extends State<AddGroupStep2Screen> {
  TextEditingController mailBoxTextEditingController = TextEditingController();
  Regions? regions;
  Districts? districts;
  Areas? areas;
  Villages? villages;
  Set<Marker> markers = {};
  LatLng? latLngState;

  void _addMarker(LatLng latLng) {
    setState(() {
      latLngState = latLng;
      print(latLngState);
      markers = {
        // ...markers,
        Marker(
          markerId: MarkerId('${latLng.latitude}-${latLng.longitude}'),
          position: latLng,
          // infoWindow: InfoWindow(title: 'Location'),
        ),
      };
    });

    print('Marker added at: Lat: ${latLng.latitude}, Lng: ${latLng.longitude}');
  }

  @override
  void initState() {
    if (widget.detailedMemberModel != null) {
      regions = getRegionFromId();
      districts = getDistrictFromId();
      areas = getAreaFromId();
      villages = getVillageFromId();
      context.read<GroupFlowCubit>().villageid =
          getVillageFromId().villageid.toString();

      mailBoxTextEditingController =
          TextEditingController(text: widget.detailedMemberModel?.pobox);

      _addMarker(LatLng(
          double.parse(widget.detailedMemberModel?.latitude ?? ''),
          double.parse(widget.detailedMemberModel?.longitude ?? '')));

      context.read<LocationCubit>().changeDistirctAccrodingToRegion(
          districtslist: context
              .read<GetOfflineCubitCubit>()
              .getOfflineDataModel!
              .districts!,
          regionIdd: getRegionFromId().regionid!);
      context.read<LocationCubit>().changeAreaAccrodingToDistrict(
          areaslist:
              context.read<GetOfflineCubitCubit>().getOfflineDataModel!.areas!,
          districtId: getDistrictFromId().districtid!);
      context.read<LocationCubit>().changeVillageAccrodingToArea(
          villageslist: context
              .read<GetOfflineCubitCubit>()
              .getOfflineDataModel!
              .villages!,
          areaId: getAreaFromId().areaid!);
    }
    print(
        'Nationallll ${context.read<AddPhysicalPersonCubit>().nationalPhoto}');

    _addMarker(LatLng(
      double.parse(
          context.read<LocationCubit>().position?.latitude.toString() ?? ''),
      double.parse(
          context.read<LocationCubit>().position?.longitude.toString() ?? ''),
    ));

    // print(widget.addPhysicalMemberStep1Model);
    super.initState();
  }

  Regions getRegionFromId() {
    for (var region
        in context.read<GetOfflineCubitCubit>().getOfflineDataModel!.regions!) {
      if (region.regionname == widget.detailedMemberModel?.region) {
        return region;
      }
    }
    return Regions();
  }

  Villages getVillageFromId() {
    for (var village in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .villages!) {
      if (village.villagename == widget.detailedMemberModel?.village) {
        return village;
      }
    }
    return Villages();
  }

  Districts getDistrictFromId() {
    for (var district in context
        .read<GetOfflineCubitCubit>()
        .getOfflineDataModel!
        .districts!) {
      if (district.districtname == widget.detailedMemberModel?.district) {
        return district;
      }
    }
    return Districts();
  }

  Areas getAreaFromId() {
    for (var area
        in context.read<GetOfflineCubitCubit>().getOfflineDataModel!.areas!) {
      if (area.areaname == widget.detailedMemberModel?.area) {
        return area;
      }
    }
    return Areas();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print('PHONE 1 ${context.read<GroupFlowCubit>().phone1}');
    print('PHONE 2 ${context.read<GroupFlowCubit>().phone2}');
    print(widget.addPhysicalMemberStep1Model);
    return SafeArea(
        top: true,
        child: Scaffold(
          appBar: const BuildAppBar(title: 'Informations Générales'),
          body: KeyboardDismisser(
            child: Padding(
              padding: globalScreenPaddings,
              child: SingleChildScrollView(
                  child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: mqh(context, 30)),
                    const BuildEasyStepperWidget(length: 6, stepNow: 2),
                    SizedBox(height: mqh(context, 40)),
                    const Text('Adresse du Siège',
                        style: GlobalTextStyles.ts20montboldGreen),
                    SizedBox(height: mqh(context, 40)),
                    BuildRegionDropDown(
                        onChange: (p0) {
                          regions = p0;
                        },
                        detailedMemberModel: widget.detailedMemberModel),
                    SizedBox(height: mqh(context, 20)),
                    BuildDepartmentDropDown(
                        onChange: (p0) {
                          districts = p0;
                        },
                        detailedMemberModel: widget.detailedMemberModel),
                    SizedBox(height: mqh(context, 20)),
                    BuildAreasDropDown(
                        onChange: (p0) {
                          areas = p0;
                        },
                        detailedMemberModel: widget.detailedMemberModel),
                    SizedBox(height: mqh(context, 20)),
                    BuildVillagesDropDown(
                        onChange: (p0) {
                          villages = p0;
                          context.read<GroupFlowCubit>().villageid =
                              p0.villageid.toString();
                          print(context.read<GroupFlowCubit>().villageid);
                        },
                        detailedMemberModel: widget.detailedMemberModel),
                    SizedBox(height: mqh(context, 20)),
                    BuildLabelWithTextField(
                      passwordTextEditingController:
                          mailBoxTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      // validator: Validations.validateEmail,
                      onChanged: (p0) {
                        context.read<GroupFlowCubit>().pobox = p0;
                        print(context.read<GroupFlowCubit>().pobox);
                      },
                      hint: 'Boite postale',
                      label: 'Boite postale',
                      showSuffixIcon: false,
                    ),
                    SizedBox(height: mqh(context, 20)),
                    // here I should put google maps widget
                    BuildMapDisplay(
                        latitude:
                            context.read<LocationCubit>().position?.latitude ??
                                7.542380,
                        longitude:
                            context.read<LocationCubit>().position?.longitude ??
                                13.544395,
                        ontap: (p0) {
                          _addMarker(p0);
                          context.read<GroupFlowCubit>().lat =
                              p0.latitude.toString();
                          context.read<GroupFlowCubit>().long =
                              p0.longitude.toString();
                          print(context.read<GroupFlowCubit>().lat);
                        },
                        markers: markers),
                    // SizedBox(height: mqh(context, 247)),
                    SizedBox(height: mqh(context, 20)),
                    BlocConsumer<UpdateLegalEntityMemberCubit,
                        UpdateLegalEntityMemberState>(
                      listener: (context, state) async {
                        if (state is UpdateLegalEntityMemberSucess) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const CustomLoaderWidget();
                            },
                          );
                          // GlobalFunctions.showLoader(context);
                          DetailedMemberModel detailedMemberModell =
                              await MemberRepository.getMemberById(
                                  jwttoken: GlobalFunctions.getLocalJWTToken(),
                                  memberId:
                                      widget.detailedMemberModel?.onlineid ??
                                          '');

                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.of(context).pushNamed(
                              Routes.nationalDetailsScreen,
                              arguments: NationalDetailScreen(
                                  detailedMemberModel: detailedMemberModell));
                        } else if (state is UpdateLegalEntityMemberFailure) {
                          GlobalSnackbar.showFailureToast(
                              context,
                              state.updateLegalEntityMemberModel?.status
                                  ?.message);
                        }
                      },
                      builder: (context, state) {
                        return BuildButton(
                          txt: 'suivant',
                          onTap: () {
                            print(context.read<GroupFlowCubit>().villageid);
                            print(context.read<GroupFlowCubit>().pobox);
                            print(context.read<GroupFlowCubit>().long);
                            print(context.read<GroupFlowCubit>().lat);
                            if (context.read<GroupFlowCubit>().villageid ==
                                    null ||
                                context.read<GroupFlowCubit>().pobox == null ||
                                context.read<GroupFlowCubit>().long == null ||
                                context.read<GroupFlowCubit>().lat == null) {
                              GlobalSnackbar.showFailureToast(context,
                                  'assurez-vous de remplir toutes les informations');
                            } else {
                              if (!(_formKey.currentState!.validate())) {
                              } else {
                                if (widget.detailedMemberModel == null) {
                                  Navigator.of(context)
                                      .pushNamed(Routes.addgroupScreen3);
                                } else {
                                  context
                                      .read<UpdateLegalEntityMemberCubit>()
                                      .updateLegalEntityMember(
                                        jwtToken:
                                            GlobalFunctions.getLocalJWTToken(),
                                        legalEntityInfo: LegalEntityInfo(
                                          villageid: context
                                              .read<GroupFlowCubit>()
                                              .villageid,
                                          offlineId: widget
                                              .detailedMemberModel?.onlineid,
                                          pobox: context
                                              .read<GroupFlowCubit>()
                                              .pobox,
                                          lat: context
                                              .read<GroupFlowCubit>()
                                              .lat,
                                          long: context
                                              .read<GroupFlowCubit>()
                                              .long,
                                        ),
                                      );
                                }
                              }
                            }
                          },
                        );
                      },
                    )
                  ],
                ),
              )),
            ),
          ),
        ));
  }
}
