import 'package:camera/camera.dart';
import 'package:capef/global_cubits/activities_cubit/activities_cubit.dart';
import 'package:capef/global_cubits/add_agri_cubit/add_agri_cubit.dart';
import 'package:capef/global_cubits/add_breeding_cubit/add_breeding_cubit.dart';
import 'package:capef/global_cubits/add_fishing_cubit/addfishingmember_cubit.dart';
import 'package:capef/global_cubits/add_forest_cubit/add_forest_cubit.dart';
import 'package:capef/global_cubits/auth_fields_cubit/authfields_cubit.dart';
import 'package:capef/global_cubits/get_member_by_id/get_member_by_id_cubit.dart';
import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/global_cubits/get_security_questions_cubit/get_security_questions_cubit.dart';
import 'package:capef/global_cubits/is_online_cubit/is_online_cubit.dart';
import 'package:capef/global_cubits/localization_cubit/localization_cubit.dart';
import 'package:capef/global_cubits/location_cubit/location_cubit.dart';
import 'package:capef/global_cubits/logout_cubit/logout_cubit.dart';
import 'package:capef/global_cubits/physical_person_cubit/add_physical_person_cubit.dart';
import 'package:capef/global_cubits/refresh_token_cubit/refresh_token_cubit.dart';
import 'package:capef/global_cubits/remove_category_cubit/remove_category_cubit.dart';
import 'package:capef/global_cubits/reports_cubit/detailed_reports_cubit.dart';
import 'package:capef/global_cubits/reports_cubit/general_reports_cubit.dart';
import 'package:capef/global_cubits/update_individual_member_cubit/update_individual_member_cubit.dart';
import 'package:capef/global_cubits/update_legal_entity_member_cubit/update_legal_entity_member_cubit.dart';
import 'package:capef/hive/hive_boxes.dart';
import 'package:capef/routes/app_router.dart';
import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/cubit/breeding_cubit.dart';
import 'package:capef/screens-cubits/change-password-screen/cubit/change_password_cubit.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/cubit/fishing_cubit.dart';
import 'package:capef/screens-cubits/forest-flow-screens/cubit/forest_cubit.dart';
import 'package:capef/screens-cubits/forget-password-screens/cubit/forget_password_cubit.dart';
import 'package:capef/screens-cubits/forget-password-screens/cubit/get_agent_by_username/get_agent_by_user_name_cubit.dart';
import 'package:capef/screens-cubits/group-flow-screens/cubit/group_flow_cubit.dart';
import 'package:capef/screens-cubits/home-screen/cubit/home_screen_cubit.dart';
import 'package:capef/screens-cubits/login-screen/cubit/login_cubit.dart';
import 'package:capef/utils/colors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens-cubits/agri-flow-screens/cubit/agri_cubit.dart';

final connectivity = Connectivity().onConnectivityChanged.listen((event) {});

var internerConnectionChecker = InternetConnectionChecker.createInstance(
  checkTimeout: const Duration(seconds: 1),
  checkInterval: const Duration(seconds: 1),
);

// final _telpoFlutterChannel = TelpoFlutterChannel();

bool? hasInternetNow;
List<CameraDescription>? cameras;
// BigInt? deviceIDApp;

const platform = MethodChannel('my_java_linker');

//  GlobalKey qrkey = GlobalKey();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory());
  cameras = await availableCameras();
  // await _telpoFlutterChannel.connect();
  await Hive.initFlutter();

  await Hive.openBox('localStorage');
  await Hive.openBox('offlineData');
  await Hive.openBox(membersBox);
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => LocalizationCubit()),
    BlocProvider(create: (context) => IsOnlineCubit()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocalizationCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => ChangePasswordCubit()),
        BlocProvider(create: (context) => HomeScreenCubit()),
        BlocProvider(create: (context) => GetSecurityQuestionsCubit()),
        BlocProvider(create: (context) => LogoutCubit()),
        BlocProvider(create: (context) => ForgetPasswordCubit()),
        BlocProvider(create: (context) => RefreshTokenCubit()),
        BlocProvider(create: (context) => AuthfieldsCubit()),
        BlocProvider(create: (context) => GetOfflineCubitCubit()),
        BlocProvider(create: (context) => AddPhysicalPersonCubit()),
        BlocProvider(create: (context) => GetAgentByUserNameCubit()),
        BlocProvider(create: (context) => GroupFlowCubit()),
        BlocProvider(create: (context) => GetReportsCubit()),
        BlocProvider(create: (context) => DetailedReportsCubit()),
        BlocProvider(create: (context) => BreedingCubit()),
        BlocProvider(create: (context) => FishingCubit()),
        BlocProvider(create: (context) => AgriCubit()),
        BlocProvider(create: (context) => LocationCubit()),
        BlocProvider(create: (context) => ForestCubit()),
        BlocProvider(create: (context) => ActivitiesCubit()),
        BlocProvider(create: (context) => AddfishingmemberCubit()),
        BlocProvider(create: (context) => AddAgriCubit()),
        BlocProvider(create: (context) => GetMemberByIdCubit()),
        BlocProvider(create: (context) => AddBreedingCubit()),
        BlocProvider(create: (context) => AddForestCubit()),
        BlocProvider(create: (context) => UpdateIndividualMemberCubit()),
        BlocProvider(create: (context) => UpdateLegalEntityMemberCubit()),
        BlocProvider(create: (context) => RemoveCategoryCubit()),
      ],
      child: BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, localeState) {
          return BuildMaterialWidget(state: localeState.locale);
        },
      ),
    );
  }
}

class BuildMaterialWidget extends StatefulWidget {
  const BuildMaterialWidget({
    super.key,
    this.state,
  });
  final String? state;

  @override
  State<BuildMaterialWidget> createState() => _BuildMaterialWidgetState();
}

class _BuildMaterialWidgetState extends State<BuildMaterialWidget> {
  String? result = 'No result';

  @override
  void initState() {
    Connectivity().onConnectivityChanged.listen((event) async {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        setState(() {});
        context.read<IsOnlineCubit>().emitIsOnline();
      } else {
        setState(() {});

        context.read<IsOnlineCubit>().emitIsOffline();
      }
    });
    // internerConnectionChecker.onStatusChange.listen((event) async {

    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String afterBuild = widget.state!;
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        return MaterialApp(
            // navigatorObservers: [routeObserver],
            debugShowCheckedModeBanner: false,
            builder: (context, widget) {
              return MaterialApp(
                title: 'CapeF',
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                locale: Locale(afterBuild, ''),
                supportedLocales: const [
                  Locale('en', ''), // English, no country code
                  Locale('fr', ''),
                ],
                theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(
                        seedColor: GlobalColors.mainGreenColor),
                    useMaterial3: true),
                onGenerateRoute: AppRouter.onGenerateRoute,
                initialRoute: Routes.splashscreen,
                debugShowCheckedModeBanner: false,
                builder: EasyLoading.init(),
              );
            });
      },
    );
  }
}
