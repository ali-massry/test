// ignore_for_file: unused_local_variable
import 'dart:developer';

import 'package:capef/routes/routes.dart';
import 'package:capef/screens-cubits/add-member-screen/add_member_screen.dart';
import 'package:capef/screens-cubits/agri-flow-screens/add_agri_category_success_screen.dart';
import 'package:capef/screens-cubits/agri-flow-screens/agri_step_1_screen.dart';
import 'package:capef/screens-cubits/agri-flow-screens/agri_step_2_screen.dart';
import 'package:capef/screens-cubits/agri-flow-screens/agri_step_3_screen.dart';
import 'package:capef/screens-cubits/agri-flow-screens/agri_step_4_screen.dart';
import 'package:capef/screens-cubits/agri-flow-screens/agri_step_5_screen.dart';
import 'package:capef/screens-cubits/agri-flow-screens/agri_step_6_screen.dart';
import 'package:capef/screens-cubits/agri-flow-screens/agri_step_7_screen.dart';
import 'package:capef/screens-cubits/agri-flow-screens/agri_step_8_screen.dart';
import 'package:capef/screens-cubits/agri-flow-screens/summary_of_agri_species_screen.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/add_breeding_category_success_screen.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/breeding_step_1_screen.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/breeding_step_2_screen.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/breeding_step_3_screen.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/breeding_step_4_screen.dart';
import 'package:capef/screens-cubits/breeding-flow-screens/summary_of_breeding_species.dart';
import 'package:capef/screens-cubits/camera-screen/camera_screen.dart';
import 'package:capef/screens-cubits/change-password-screen/cubit/change_password_cubit.dart';
import 'package:capef/screens-cubits/change-password-screen/ui/change_password_screen.dart';
import 'package:capef/screens-cubits/choose-language-screen/cubit/choose_language_cubit.dart';
import 'package:capef/screens-cubits/choose-language-screen/ui/choose_language_screen.dart';
import 'package:capef/screens-cubits/detailed-reports-screen/detailed_reports_screen.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/add_fishing_category_success_screen.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/fishing_step_1_screen.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/fishing_step_2_screen.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/fishing_step_3_screen.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/fishing_step_4_screen.dart';
import 'package:capef/screens-cubits/fishing-flow-screens/summary_of_fishing_species.dart';
import 'package:capef/screens-cubits/forest-flow-screens/add_forest_success_screen.dart';
import 'package:capef/screens-cubits/forest-flow-screens/forest_step_1_screen.dart';
import 'package:capef/screens-cubits/forest-flow-screens/forest_step_2_screen.dart';
import 'package:capef/screens-cubits/forest-flow-screens/forestry-operator-ui/forestry_operator_step_1_screen.dart';
import 'package:capef/screens-cubits/forest-flow-screens/forestry-operator-ui/summary_of_forestry_operator.dart';
import 'package:capef/screens-cubits/forest-flow-screens/pnfl-operator-ui/pnfl_operator_step_1_screen.dart';
import 'package:capef/screens-cubits/forest-flow-screens/pnfl-operator-ui/summary_of_pnfl_operator.dart';
import 'package:capef/screens-cubits/forest-flow-screens/silviculturist-ui/silviculturist_step_1_screen.dart';
import 'package:capef/screens-cubits/forest-flow-screens/silviculturist-ui/summary_of_silviculturist.dart';
import 'package:capef/screens-cubits/forest-flow-screens/wild-life-products-operators-ui/summary_of_wild_life_products_operator_screen.dart';
import 'package:capef/screens-cubits/forest-flow-screens/wild-life-products-operators-ui/wild_life_products_operator_step_1_screen.dart';
import 'package:capef/screens-cubits/forget-password-screens/cubit/forget_password_cubit.dart';
import 'package:capef/screens-cubits/forget-password-screens/forget_password_step_1.dart';
import 'package:capef/screens-cubits/forget-password-screens/forget_password_step_2.dart';
import 'package:capef/screens-cubits/forget-password-screens/forget_password_step_3.dart';
import 'package:capef/screens-cubits/group-flow-screens/group_success_screen.dart';
import 'package:capef/screens-cubits/group-flow-screens/step-1/group_step_1_screen.dart';
import 'package:capef/screens-cubits/group-flow-screens/step-2/group_step_2_screen.dart';
import 'package:capef/screens-cubits/group-flow-screens/step-3/group_step_3_screen.dart';
import 'package:capef/screens-cubits/group-flow-screens/step-4/group_step_4_screen.dart';
import 'package:capef/screens-cubits/group-flow-screens/step-5/group_step_5_screen.dart';
import 'package:capef/screens-cubits/group-flow-screens/step-6/group_step_6_screen.dart';
import 'package:capef/screens-cubits/home-screen/cubit/home_screen_cubit.dart';
import 'package:capef/screens-cubits/home-screen/ui/home_screen.dart';
import 'package:capef/screens-cubits/image-confirmation-screen/image_confirmation_screen.dart';
import 'package:capef/screens-cubits/login-screen/cubit/login_cubit.dart';
import 'package:capef/screens-cubits/login-screen/ui/login_screen.dart';
import 'package:capef/screens-cubits/manage-nationals-screen/manage_national_screen.dart';
import 'package:capef/screens-cubits/national-area-screen/national_area_screen.dart';
import 'package:capef/screens-cubits/national-detail-screen/national_detail_screen.dart';
import 'package:capef/screens-cubits/physical-person-flow/physical_person_success_screen.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-1/physical_person_step_1_screen.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-2/physical_person_step_2_screen.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-3/physical_person_step_3_screen.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-4/physical_person_step_4_screen.dart';
import 'package:capef/screens-cubits/physical-person-flow/step-6/physical_person_step_6_screen.dart';
import 'package:capef/screens-cubits/reports-screen/reports_screen.dart';
import 'package:capef/screens-cubits/search-reports-screen/search_reports_screen.dart';
import 'package:capef/screens-cubits/splash-screen/cubit/splashscreen_cubit.dart';
import 'package:capef/screens-cubits/splash-screen/ui/splash_screen.dart';
import 'package:capef/screens-cubits/synchronise-nationals-screen/synchronise_national_sreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens-cubits/physical-person-flow/step-5/physical_person_step_5_screen.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    log('GOING TO: ${settings.name}');
    switch (settings.name) {
      case Routes.splashscreen:
        // final args = settings.arguments as SplashScreen;

        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => SplashscreenCubit()),
            ],
            child: const SplashScreen(),
          ),
        );
      case Routes.homeScreen:
        // final args = settings.arguments as SplashScreen;

        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => HomeScreenCubit()),
            ],
            child: const HomeScreen(),
          ),
        );
      case Routes.chooseLanguageScreen:
        // final args = settings.arguments as SplashScreen;

        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ChooseLanguageCubit()),
            ],
            child: const ChooseLanguageScreen(),
          ),
        );
      case Routes.loginScreen:
        // final args = settings.arguments as SplashScreen;

        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => LoginCubit()),
            ],
            child: const LoginScreen(),
          ),
        );
      case Routes.changePasswordScreen:
        // final args = settings.arguments as SplashScreen;

        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ChangePasswordCubit())
            ],
            child: const ChangePasswordScreen(),
          ),
        );
      case Routes.forgetPasswordStep1Screen:
        // final args = settings.arguments as SplashScreen;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ForgetPasswordCubit())
            ],
            child: const ForgetPasswordFirstStep(),
          ),
        );
      case Routes.forgetPasswordStep2Screen:
        final args = settings.arguments as ForgetPasswordSecondStep;

        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ForgetPasswordCubit())
            ],
            child: ForgetPasswordSecondStep(userName: args.userName),
          ),
        );
      case Routes.forgetPasswordStep3Screen:
        final args = settings.arguments as ForgetPasswordThirdStep;

        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ForgetPasswordCubit())
            ],
            child: ForgetPasswordThirdStep(
                userName: args.userName, answer: args.answer),
          ),
        );
      case Routes.reportsScreen:
        // final args = settings.arguments as SplashScreen;

        return MaterialPageRoute(
          builder: (context) => const ReportsScreen(),
        );
      case Routes.addMemberScreen:
        // final args = settings.arguments as SplashScreen;

        return MaterialPageRoute(
          builder: (context) => const AddMemberScreen(),
        );
      case Routes.searchReportsScreen:
        final args = settings.arguments as SearchReportsScreen;

        return MaterialPageRoute(
          builder: (context) =>
              SearchReportsScreen(from: args.from, to: args.to),
        );
      case Routes.addAgriSuccessScreen:
        // final args = settings.arguments as SearchReportsScreen;

        return MaterialPageRoute(
          builder: (context) => const AddAgriSuccessScreen(),
        );
      case Routes.summaryOfsilviculturer:
        // final args = settings.arguments as SearchReportsScreen;

        return MaterialPageRoute(
          builder: (context) => const SummaryOfSilviculturist(),
        );
      case Routes.summaryOfpnflOperator:
        // final args = settings.arguments as SearchReportsScreen;
        return MaterialPageRoute(
          builder: (context) => const SummaryOfPnflOperator(),
        );
      case Routes.summaryOfwildlifeproductsOperator:
        // final args = settings.arguments as SearchReportsScreen;

        return MaterialPageRoute(
          builder: (context) => const SummaryOfWildLifeProductsOperator(),
        );
      case Routes.addForestSuccessScreen:
        // final args = settings.arguments as SearchReportsScreen;
        return MaterialPageRoute(
          builder: (context) => const AddForestSuccessScreen(),
        );
      case Routes.nationalAreaScreen:
        // final args = settings.arguments as SearchReportsScreen;

        return MaterialPageRoute(
          builder: (context) => const NationalsAreaScreen(),
        );
      case Routes.synchroniseNationalsScreen:
        // final args = settings.arguments as SearchReportsScreen;

        return MaterialPageRoute(
          builder: (context) => const SynchroniseNationalsScreen(),
        );
      case Routes.manageNationalsScreen:
        // final args = settings.arguments as SearchReportsScreen;
        return MaterialPageRoute(
            builder: (context) => const ManageNationalsScreen());
      case Routes.nationalDetailsScreen:
        final args = settings.arguments as NationalDetailScreen;
        return MaterialPageRoute(
            builder: (context) => NationalDetailScreen(
                detailedMemberModel: args.detailedMemberModel));
      case Routes.addPhysicalPersonScreen1:
        final args = settings.arguments as AddPhysicalPersonStep1Screen;
        return MaterialPageRoute(
            builder: (context) => AddPhysicalPersonStep1Screen(
                detailedMemberModel: args.detailedMemberModel));
      case Routes.imageConfirmationScreen:
        final args = settings.arguments as ImageConfirmationScreen;
        return MaterialPageRoute(
            builder: (context) => ImageConfirmationScreen(
                  imageFile: args.imageFile,
                  photo: args.photo,
                ));
      case Routes.cameraScreen:
        final args = settings.arguments as CameraScreen;
        return MaterialPageRoute(
          builder: (context) => CameraScreen(photo: args.photo),
        );
      case Routes.addPhysicalPersonScreen2:
        final args = settings.arguments as AddPhysicalPersonStep2Screen;
        return MaterialPageRoute(
          builder: (context) => AddPhysicalPersonStep2Screen(
              addPhysicalMemberStep1Model: args.addPhysicalMemberStep1Model,
              detailedMemberModel: args.detailedMemberModel),
        );
      case Routes.addPhysicalPersonScreen3:
        final args = settings.arguments as AddPhysicalPersonStep3Screen;
        return MaterialPageRoute(
          builder: (context) => AddPhysicalPersonStep3Screen(
              addPhysicalMemberStep2Model: args.addPhysicalMemberStep2Model,
              detailedMemberModel: args.detailedMemberModel),
        );
      case Routes.addPhysicalPersonScreen4:
        final args = settings.arguments as AddPhysicalPersonStep4Screen;
        return MaterialPageRoute(
          builder: (context) => AddPhysicalPersonStep4Screen(
              addPhysicalMemberStep3Model: args.addPhysicalMemberStep3Model),
        );
      case Routes.addPhysicalPersonScreen5:
        final args = settings.arguments as AddPhysicalPersonStep5Screen;
        return MaterialPageRoute(
          builder: (context) => AddPhysicalPersonStep5Screen(
              addPhysicalMemberStep4Model: args.addPhysicalMemberStep4Model),
        );
      case Routes.addPhysicalPersonScreen6:
        final args = settings.arguments as AddPhysicalPersonStep6Screen;
        return MaterialPageRoute(
          builder: (context) => AddPhysicalPersonStep6Screen(
            addPhysicalMemberStep5Model: args.addPhysicalMemberStep5Model,
          ),
        );
      case Routes.addgroupScreen1:
        final args = settings.arguments as AddGroupStep1Screen;
        return MaterialPageRoute(
          builder: (context) => AddGroupStep1Screen(
            detailedMemberModel: args.detailedMemberModel,
          ),
        );
      case Routes.addgroupScreen2:
        final args = settings.arguments as AddGroupStep2Screen;
        return MaterialPageRoute(
          builder: (context) => AddGroupStep2Screen(
            detailedMemberModel: args.detailedMemberModel,
            // addPhysicalMemberStep5Model: args.addPhysicalMemberStep5Model,
          ),
        );
      case Routes.addgroupScreen3:
        // final args = settings.arguments as AddPhysicalPersonStep6Screen;
        return MaterialPageRoute(
          builder: (context) => const AddGroupStep3Screen(
              // addPhysicalMemberStep5Model: args.addPhysicalMemberStep5Model,
              ),
        );
      case Routes.addgroupScreen4:
        // final args = settings.arguments as AddPhysicalPersonStep6Screen;
        return MaterialPageRoute(
          builder: (context) => const AddGroupStep4Screen(
              // addPhysicalMemberStep5Model: args.addPhysicalMemberStep5Model,
              ),
        );
      case Routes.addgroupScreen5:
        // final args = settings.arguments as AddPhysicalPersonStep6Screen;
        return MaterialPageRoute(
          builder: (context) => const AddGroupStep5Screen(
              // addPhysicalMemberStep5Model: args.addPhysicalMemberStep5Model,
              ),
        );
      case Routes.addgroupScreen6:
        // final args = settings.arguments as AddPhysicalPersonStep6Screen;
        return MaterialPageRoute(
          builder: (context) => const AddGroupStep6Screen(
              // addPhysicalMemberStep5Model: args.addPhysicalMemberStep5Model,
              ),
        );
      case Routes.physicalPersonSuccessScreen:
        final args = settings.arguments as PhysicalPersonSuccessScreen;
        return MaterialPageRoute(
            builder: (context) => PhysicalPersonSuccessScreen(
                addPhysicalMemberStep6Model: args.addPhysicalMemberStep6Model,
                onlineOrOfllineId: args.onlineOrOfllineId,
                transactionId: args.transactionId));
      case Routes.groupSuccessScreen:
        final args = settings.arguments as GroupSuccessScreen;
        return MaterialPageRoute(
            builder: (context) => GroupSuccessScreen(
                  onlineOrOfllineId: args.onlineOrOfllineId,
                  transactionIDD: args.transactionIDD,
                  // addPhysicalMemberStep6Model: args.addPhysicalMemberStep6Model,
                ));
      case Routes.fishingStep1Screen:
        return MaterialPageRoute(
            builder: (context) => const FishingStep1Screen());
      case Routes.fishingStep2Screen:
        return MaterialPageRoute(
            builder: (context) => const FishingStep2Screen());
      case Routes.fishingStep3Screen:
        return MaterialPageRoute(
            builder: (context) => const FishingStep3Screen());
      case Routes.fishingStep4Screen:
        return MaterialPageRoute(
            builder: (context) => const FishingStep4Screen());
      case Routes.agriStep1Screen:
        return MaterialPageRoute(builder: (context) => const AgriStep1Screen());
      case Routes.agriStep2Screen:
        return MaterialPageRoute(builder: (context) => const AgriStep2Screen());
      case Routes.agriStep3Screen:
        return MaterialPageRoute(builder: (context) => const AgriStep3Screen());
      case Routes.agriStep4Screen:
        return MaterialPageRoute(builder: (context) => const AgriStep4Screen());
      case Routes.agriStep5Screen:
        return MaterialPageRoute(builder: (context) => const AgriStep5Screen());
      case Routes.agriStep6Screen:
        return MaterialPageRoute(builder: (context) => const AgriStep6Screen());
      case Routes.agriStep7Screen:
        return MaterialPageRoute(builder: (context) => const AgriStep7Screen());
      case Routes.agriStep8Screen:
        return MaterialPageRoute(builder: (context) => const AgriStep8Screen());
      case Routes.summaryOfFishingSpeciesScreen:
        return MaterialPageRoute(
            builder: (context) => const SummaryOfFishingSpeciesScreen());
      case Routes.summaryOfAgriSpeciesScreen:
        return MaterialPageRoute(
            builder: (context) => const SummaryOfAgriSpeciesScreen());
      case Routes.addFishingSuccessScreen:
        return MaterialPageRoute(
            builder: (context) => const AddFishingSuccessScreen());
      case Routes.breedingStep1Screen:
        return MaterialPageRoute(
            builder: (context) => const BreedingStep1Screen());
      case Routes.breedingStep2Screen:
        return MaterialPageRoute(
            builder: (context) => const BreedingStep2Screen());
      case Routes.breedingStep3Screen:
        return MaterialPageRoute(
            builder: (context) => const BreedingStep3Screen());
      case Routes.breedingStep4Screen:
        final args = settings.arguments as BreedingStep4Screen;

        return MaterialPageRoute(
            builder: (context) =>
                BreedingStep4Screen(resetAllValues: args.resetAllValues));
      case Routes.forestStep1Screen:
        return MaterialPageRoute(
            builder: (context) => const ForestStep1Screen());
      case Routes.forestStep2Screen:
        return MaterialPageRoute(
            builder: (context) => const ForestStep2Screen());
      case Routes.summaryOfforestryOperator:
        return MaterialPageRoute(
            builder: (context) => const SummaryOfForestryOperator());
      case Routes.summaryOfBreedingSpeciesScreen:
        return MaterialPageRoute(
            builder: (context) => const SummaryOfBreedingSpeciesScreen());
      case Routes.addBreedingSuccessScreen:
        return MaterialPageRoute(
            builder: (context) => const AddBreedingSuccessScreen());
      case Routes.forestryOperatorStep1Screen:
        return MaterialPageRoute(
            builder: (context) => const ForestryOperatorScreen1());
      case Routes.wildLifeProductsOperatorStep1Screen:
        return MaterialPageRoute(
            builder: (context) => const WildLifeProductsOperatorStep1Screen());
      case Routes.pnflOperatorStep1Screen:
        return MaterialPageRoute(
            builder: (context) => const PnflOperatorStep1Screen());
      case Routes.silviculturistStep1Screen:
        return MaterialPageRoute(
            builder: (context) => const SylviculturistScreen1());
      case Routes.detailedReportsScreen:
        final args = settings.arguments as DetailedReportsScreen;
        return MaterialPageRoute(
          builder: (context) => DetailedReportsScreen(
            title: args.title,
            categoryId: args.categoryId,
            from: args.from,
            to: args.to,
          ),
        );

      default:
        return null;
    }
  }
}
