// ignore_for_file: deprecated_member_use

import 'package:capef/global_cubits/get_offline_cubit/get_offline_cubit.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class BuildDemandAssistanceWidget extends StatelessWidget {
  BuildDemandAssistanceWidget({super.key, this.ontap});
  VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title:  Text('Contact Options', style: GlobalTextStyles.ts16montBoldGreen),
              content: SizedBox(
                width: 200,
                height: 160,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Replace 'supportNumber' with the actual support phone number
                        launch(
                            'tel:+${context.read<GetOfflineCubitCubit>().getOfflineDataModel?.supportNumber}');
                        Navigator.pop(context); // Close the dialog
                      },
                      child: const Text('Call Support'),
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: () {
                        // Replace 'whatsappNumber' with the actual WhatsApp number
                        launch(
                            'https://wa.me/${context.read<GetOfflineCubitCubit>().getOfflineDataModel?.whatsappNumber}');
                        Navigator.pop(context); // Close the dialog
                      },
                      child: const Text('WhatsApp'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Text(
        AppLocalizations.of(context)!.demand_assistance,
        style: GlobalTextStyles.underlinedViewAllTextButton,
      ),
    );
  }
}
