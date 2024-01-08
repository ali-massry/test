import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:capef/widgets/text_field.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BuildLabelWithTextField extends StatefulWidget {
  const BuildLabelWithTextField({
    super.key,
    required this.passwordTextEditingController,
    required this.hint,
    required this.label,
    this.showSuffixIcon,
    this.onChanged,
    this.keyboardType,
    this.prefixIcon,
    this.maxLength,
    this.validator,
  });

  final TextEditingController? passwordTextEditingController;
  final String? label;
  final String? hint;
  final int? maxLength;

  final bool? showSuffixIcon;
  final Function(String?)? onChanged;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;

  @override
  State<BuildLabelWithTextField> createState() =>
      _BuildLabelWithTextFieldState();
}

class _BuildLabelWithTextFieldState extends State<BuildLabelWithTextField> {
  bool? obscure = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: mqw(context, 15)),
          child: Text(
            widget.label!.toUpperCase(),
            style: GlobalTextStyles.ts12ls1montboldGreen,
          ),
        ),
        SizedBox(height: mqh(context, 5)),
        CustomMainTextField(
          hintText: widget.hint,
          
          maxLength: widget.maxLength ?? 30,
          textEditingController: widget.passwordTextEditingController,
          obscureText: obscure,
          suffixIcon: widget.showSuffixIcon == false
              ? const SizedBox()
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      obscure = !obscure!;
                    });
                  },
                  child: Icon(
                    obscure! ? Icons.visibility_off : Icons.visibility,
                    color: GlobalColors.mainGreenColor,
                  ),
                ),
          keyboardType: widget.keyboardType ?? TextInputType.name,
          onChanged: widget.onChanged,
          prefixIcon: widget.prefixIcon,
          validator: widget.validator,
          textCapitalization: TextCapitalization.none,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
