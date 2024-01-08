import 'package:capef/assets.dart';
import 'package:capef/screens-cubits/manage-nationals-screen/manage_national_screen.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/svg_builder.dart';
import 'package:capef/widgets/label_with_textfield.dart';
import 'package:flutter/material.dart';

class ManageNationalBody extends StatelessWidget {
  const ManageNationalBody({super.key, this.idTestEditingController});
  final TextEditingController? idTestEditingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            SizedBox(height: mqh(context, 40)),
            SizedBox(
              width: mqw(context, 250),
              child: const Text(
                'RECHERCHER LE PROFIL D’UN RESSORTISSANT',
                style: GlobalTextStyles.ts20montboldGreen,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: mqh(context, 40)),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QRViewExample(),
                ));
              },
              child: Card(
                elevation: 5,
                child: Container(
                  width: double.infinity,
                  height: mqh(context, 150),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              width: mqw(context, 60),
                              height: mqh(context, 60),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: GlobalColors.mainGreenColor
                                      .withOpacity(0.1)),
                              child: Center(
                                  child:
                                      SvgBuilder(asset: Assets.icons.camSvg)),
                            ),
                          ),
                          SizedBox(height: mqh(context, 15)),
                          const Text(
                            'SCANNER LE QR CODE',
                            style: GlobalTextStyles.ts15montboldBlack,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: mqh(context, 50)),
            BuildLabelWithTextField(
                passwordTextEditingController: idTestEditingController,
                hint: 'Saisir l’identifiant de sa carte',
                showSuffixIcon: false,
                keyboardType: TextInputType.number,
                label: 'Saisir l’identifiant de sa carte')
          ],
        ),
      ],
    );
  }
}
