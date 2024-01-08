// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/global_cubits/location_cubit/location_cubit.dart';
import 'package:capef/global_cubits/physical_person_cubit/add_physical_person_cubit.dart';
import 'package:capef/global_cubits/update_individual_member_cubit/update_individual_member_cubit.dart';
import 'package:capef/models/offline_data_response.dart';
import 'package:capef/models/user_info_model.dart';
import 'package:capef/repositories/member_repo/member_repository.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/national-detail-screen/national_detail_screen.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-2/step_2_model.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-3/step_3_model.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-4/physical_person_step_4_screen.dart';
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
import '../../../models/detailed_member_model.dart';

class AddPhysicalPersonStep3Screen extends StatefulWidget {
  const AddPhysicalPersonStep3Screen(
      {super.key, this.addPhysicalMemberStep2Model, this.detailedMemberModel});
  final PersonalInfoWithPhotoModel? addPhysicalMemberStep2Model;
  final DetailedMemberModel? detailedMemberModel;

  @override
  State<AddPhysicalPersonStep3Screen> createState() =>
      _AddPhysicalPersonStep3ScreenState();
}

class _AddPhysicalPersonStep3ScreenState
    extends State<AddPhysicalPersonStep3Screen> {
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
    var s = widget.detailedMemberModel;
    print(s);

    if (widget.detailedMemberModel != null) {
      regions = getRegionFromId();
      districts = getDistrictFromId();
      areas = getAreaFromId();
      villages = getVillageFromId();

      mailBoxTextEditingController =
          TextEditingController(text: widget.detailedMemberModel?.pobox);

      _addMarker(LatLng(
          double.parse(widget.detailedMemberModel?.latitude ?? ''),
          double.parse(widget.detailedMemberModel?.longitude ?? '')));

      print(mailBoxTextEditingController.text);
      print(latLngState);

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

    _addMarker(LatLng(
      double.parse(
          context.read<LocationCubit>().position?.latitude.toString() ?? ''),
      double.parse(
          context.read<LocationCubit>().position?.longitude.toString() ?? ''),
    ));

    print(
        'Nationallll ${context.read<AddPhysicalPersonCubit>().nationalPhoto}');

    // print(widget.addPhysicalMemberStep1Model);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          appBar: const BuildAppBar(title: 'Information CNI'),
          body: KeyboardDismisser(
            child: Padding(
              padding: globalScreenPaddings,
              child: SingleChildScrollView(
                  child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: mqh(context, 30)),
                    const BuildEasyStepperWidget(length: 6, stepNow: 3),
                    SizedBox(height: mqh(context, 40)),
                    const Text('Lieu De Résidence',
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
                        },
                        detailedMemberModel: widget.detailedMemberModel),
                    SizedBox(height: mqh(context, 20)),
                    BuildLabelWithTextField(
                      passwordTextEditingController:
                          mailBoxTextEditingController,
                      // validator: Validations.validateEmail,
                      hint: 'Boite postale',
                      label: 'Boite postale',
                      keyboardType: TextInputType.emailAddress,
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
                        },
                        markers: markers),
                    // SizedBox(height: mqh(context, 247)),
                    SizedBox(height: mqh(context, 20)),
                    BlocConsumer<UpdateIndividualMemberCubit,
                        UpdateIndividualMemberState>(
                      listener: (context, state) async {
                        if (state is UpdateIndividualMemberSucess) {
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
                        } else if (state is UpdateIndividualMemberFailure) {
                          GlobalSnackbar.showFailureToast(
                              context,
                              state.updateLIndividualMemberModel?.status
                                  ?.message);
                        }
                      },
                      builder: (context, state) {
                        return BuildButton(
                          txt: 'suivant',
                          onTap: () {
                            if ((_formKey.currentState!.validate())) {
                              if (villages == null) {
                                GlobalSnackbar.showFailureToast(context,
                                    'Remplissez toutes les informations');
                              } else {
                                if (widget.detailedMemberModel != null) {
                                  context.read<UpdateIndividualMemberCubit>().updateIndividualMember(
                                      jwtToken:
                                          GlobalFunctions.getLocalJWTToken(),
                                      userInfo: UserInfo(
                                          firstname: '',
                                          lastname: '',
                                          offlineId: widget.detailedMemberModel
                                                  ?.onlineid ??
                                              '',
                                          meterialStatusid: '',
                                          pin: '',
                                          secanswer: '',
                                          securityqstid: '',
                                          pobox:
                                              mailBoxTextEditingController.text,
                                          latitude: latLngState?.latitude
                                                  .toString() ??
                                              '',
                                          longitude: latLngState?.longitude
                                                  .toString() ??
                                              '',
                                          mainactivityid: '',
                                          secondaryactivityid: '',
                                          civilityid: '',
                                          genderid: '',
                                          dob: '',
                                          placeofbirth: '',
                                          phone1: '',
                                          phone2: '',
                                          email: '',
                                          op: '',
                                          cni: '',
                                          villageid:
                                              villages?.villageid.toString() ??
                                                  '',
                                          seasonpayment: '',
                                          subscriptionpayment: ''),
                                      userInfoEdited: null);
                                } else {
                                  Navigator.of(context).pushNamed(
                                      Routes.addPhysicalPersonScreen4,
                                      arguments: AddPhysicalPersonStep4Screen(
                                        addPhysicalMemberStep3Model:
                                            PersonalInfoWithLocationInfoModel(
                                          addPhysicalMemberStep2Model: widget
                                              .addPhysicalMemberStep2Model,
                                          areaId: areas?.areaid,
                                          departmentId: districts?.districtid,
                                          latLng: latLngState,
                                          mailBox:
                                              mailBoxTextEditingController.text,
                                          regionId: regions?.regionid,
                                          villageId: villages?.villageid,
                                        ),
                                      ));
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
