import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextfiled extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function? onChanged;
  final int maxLines;
  final bool readOnly;
  final bool obscureText;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final int maxLength;
  final Color? borderColor;
  final Color? fillColor;
  final Widget suffixIcon;
  final TextAlign textAlign;
  final bool autofocus;
  final Function? ontapsuffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  const CustomTextfiled({
    super.key,
    required this.controller,
    required this.hintText,
    this.focusNode,
    this.obscureText = false,
    this.fillColor,
    this.onChanged,
    this.textAlign = TextAlign.left,
    this.maxLength = 100,
    this.autofocus = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.ontapsuffixIcon,
    this.inputFormatters,
    this.suffixIcon = const SizedBox(),
    this.readOnly = false,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: textAlign,
      focusNode: focusNode,
      autofocus: autofocus,
      maxLength: maxLength,
      readOnly: readOnly,
      controller: controller,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      obscureText: obscureText,
      obscuringCharacter: "*",
      decoration: InputDecoration(
        fillColor: fillColor ?? Theme.of(context).colorScheme.onTertiary,
        filled: true,
        counterText: "",
        contentPadding: const EdgeInsets.all(10),
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0.5,
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: borderColor ?? Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            if (ontapsuffixIcon != null) {
              ontapsuffixIcon!();
            }
          },
          child: Container(
            padding: const EdgeInsets.only(right: 10),
            child: suffixIcon,
          ),
        ),
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 25,
          maxWidth: 25,
        ),
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Theme.of(context).colorScheme.primary),
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters ?? [],
      maxLines: maxLines,
    );
  }
}
