import 'package:capef/global_cubits/activities_cubit/activities_cubit.dart';
import 'package:capef/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildQuestionaireButton extends StatelessWidget {
  const BuildQuestionaireButton({super.key, required this.activityId});
  final int? activityId;

  @override
  Widget build(BuildContext context) {
    return BuildButton(
      txt: 'Questionnaire Activité Secondaire',
      onTap: () async {
        context.read<ActivitiesCubit>().clearSecondaryAndNavigateAccordingle(
            context,
            currentActivityId: activityId);
      },
    );
  }
}
