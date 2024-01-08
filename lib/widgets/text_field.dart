import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';

class CustomMainTextField extends StatelessWidget {
  const CustomMainTextField(
      {Key? key,
      this.keyboardType,
      this.textInputAction,
      this.textCapitalization,
      this.obscureText,
      this.onChanged,
      this.hintText,
      this.suffixIcon,
      this.prefixIcon,
      this.validator,
      this.isReadOnly,
      this.initialValue,
      this.fillColor,
      this.isFilled,
      this.autoFocus,
      this.textEditingController,
      this.maxLength})
      : super(key: key);

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final bool? obscureText;
  final Function(String?)? onChanged;
  final bool? isReadOnly;
  final String? initialValue;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final Color? fillColor;
  final bool? isFilled;
  final bool? autoFocus;
  final TextEditingController? textEditingController;
  final int? maxLength;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mqh(context, 55),
      child: TextFormField(
        controller: textEditingController,
        maxLength: maxLength,
        cursorColor: GlobalColors.mainGreenColor,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        onChanged: onChanged,
        readOnly: isReadOnly ?? false,

        autofocus: autoFocus ?? false,
        validator: validator,
        initialValue:
            (textEditingController != null) ? null : initialValue ?? '',
        textInputAction: TextInputAction.next,
        // style: ts15SourceSansProRegular,
        decoration: InputDecoration(
          counterText: '',
          fillColor: fillColor,
          filled: isFilled ?? false,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          errorStyle: const TextStyle(
              fontFamily: GlobalFonts.monserratSemiBold, letterSpacing: 0.3),
          hintStyle: GlobalTextStyles.ts13montsemiBold30OpaquBlack,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]!),
            borderRadius: BorderRadius.circular(50),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(50),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]!),
            borderRadius: BorderRadius.circular(50),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]!),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
