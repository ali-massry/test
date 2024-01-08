import 'package:capef/assets.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/utils/svg_builder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuildLabelWithDatePicker extends StatefulWidget {
  const BuildLabelWithDatePicker({
    Key? key,
    this.label,
    required this.onDateSelected,
    required this.dateTime,
    this.hint,
  }) : super(key: key);

  final String? label;
  final DateTime? dateTime;
  final Function(DateTime) onDateSelected;
  final String? hint;

  @override
  // ignore: library_private_types_in_public_api
  _BuildLabelWithDatePickerState createState() =>
      _BuildLabelWithDatePickerState();
}

class _BuildLabelWithDatePickerState extends State<BuildLabelWithDatePicker> {
  DateTime? selectedDate;

  @override
  void initState() {
    widget.hint ?? 'DD / MM / YYYY';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: mqw(context, 15)),
          child: Text(
            widget.label?.toUpperCase() ?? '',
            style: GlobalTextStyles.ts12ls1montboldGreen,
          ),
        ),
        SizedBox(height: mqh(context, 5)),
        GestureDetector(
          onTap: () {
            _selectDate(context, dateTimeToStart: widget.dateTime);
          },
          child: Container(
            height: mqh(context, 50),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black.withOpacity(0.15)),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedDate != null
                        ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                        : widget.hint ?? 'DD / MM / YYYY',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontFamily: GlobalFonts.montserratBold,
                    ),
                  ),
                  SvgBuilder(asset: Assets.icons.calendarSvg),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<void> _selectDate(BuildContext context,
      {required DateTime? dateTimeToStart}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateTimeToStart!,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: GlobalColors.mainGreenColor,
            colorScheme: ColorScheme.dark(
              primary: GlobalColors.mainGreenColor,
              onPrimary: Colors.black.withOpacity(0.8),
              surface: Colors.black.withOpacity(0.8),
              onSurface: GlobalColors.mainGreenColor,
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
      widget.onDateSelected(pickedDate);
    }
  }
}
