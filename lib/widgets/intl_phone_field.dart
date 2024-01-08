import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class BuildIntlPhoneFieldWithLabel extends StatelessWidget {
  const BuildIntlPhoneFieldWithLabel({
    super.key,
    required this.textt,
    required this.onChangephoneNumber,
  });
  final String? textt;
  final Function(PhoneNumber)? onChangephoneNumber;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(left: mqw(context, 15)),
        child: Text(
          textt?.toUpperCase() ?? '',
          style: GlobalTextStyles.ts12ls1montboldGreen,
        ),
      ),
      SizedBox(height: mqh(context, 5)),
      IntlPhoneField(
        flagsButtonPadding: const EdgeInsets.only(left: 15),
        decoration: InputDecoration(
          // labelText: textt,
          hintText: textt,
          labelStyle: GlobalTextStyles.ts13montsemiBold30OpaquBlack,
          hintStyle: GlobalTextStyles.ts13montsemiBold30OpaquBlack,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
        ),
        initialCountryCode: 'CM',
        keyboardType: TextInputType.number,
        showDropdownIcon: false,
        onChanged: onChangephoneNumber,
      )
    ]);
  }
}
