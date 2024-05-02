import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Cusotmtextfile02 extends StatefulWidget {
  final String? initialValue;
  final GestureTapCallback? ontapIcon;
  final String? labelText;
  final String? validateText;
  final ValueChanged<String>? onChange;
  final ValueChanged<bool>? onFocusChange;
  final bool required;
  final String? hintText;
  final GestureTapCallback? onTap;
  final FormFieldSetter<String>? onSave;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? isValidate;
  final TextEditingController? controller;
  final bool? isObscureText;
  final String? Function(String?)? validator;
  final TextStyle? hintStyle;
  final TextInputType? keyboard;
  final FocusNode? focusNode;
  final int maxLines;
  final int? minLines;
  final bool? noBorder;
  final double? height;
  final bool readOnly;
  final TextDirection? textDirection;
  final List<TextInputFormatter>? inputFormatters;
  final bool? isMaxline;

  const Cusotmtextfile02({
    this.prefixIcon,
    this.validator,
    this.readOnly = false,
    this.noBorder = false,
    this.maxLines = 1,
    this.minLines,
    this.labelText,
    this.isObscureText = false,
    this.required = false,
    this.focusNode,
    this.onFocusChange,
    this.validateText,
    super.key,
    this.controller,
    this.initialValue,
    this.onChange,
    this.hintText,
    this.onTap,
    this.onSave,
    this.keyboardType,
    this.suffixIcon,
    this.isValidate = false,
    this.ontapIcon,
    this.height,
    this.textDirection,
    this.inputFormatters,
    this.hintStyle,
    this.keyboard,
    this.isMaxline = false,
  });

  @override
  State<Cusotmtextfile02> createState() => _Cusotmtextfile02State();
}

class _Cusotmtextfile02State extends State<Cusotmtextfile02> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: widget.isMaxline == false
      //     ? widget.maxLines > 1
      //         ? widget.maxLines * 35
      //         : 70
      //     : 35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (widget.labelText != null)
            Text(
              widget.labelText ?? '',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          if (widget.labelText != null)
            const SizedBox(
              height: 5,
            ),
          Container(
            height: widget.height ?? 35,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 15, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: widget.noBorder == false
                  ? Theme.of(context).colorScheme.background
                  : widget.isValidate!
                      ? Colors.red[100]
                      : Theme.of(context).cardColor,
              border: Border.all(
                width: 1,
                color: widget.noBorder == false
                    ? Theme.of(context).disabledColor
                    : Colors.transparent,
              ),
            ),
            child: Focus(
              onFocusChange: widget.onFocusChange,
              child: TextFormField(
                onTap: widget.onTap,
                keyboardType: widget.keyboard,
                inputFormatters: widget.inputFormatters,
                textDirection: widget.textDirection ?? TextDirection.ltr,
                readOnly: widget.readOnly,
                initialValue: widget.initialValue,
                controller: widget.controller,
                style: Theme.of(context).textTheme.displayMedium,
                onChanged: widget.onChange,
                obscureText: widget.isObscureText!,
                validator: widget.validator,
                maxLines: widget.maxLines,
                minLines: widget.maxLines,
                decoration: InputDecoration(
                  errorStyle: const TextStyle(color: Colors.red),
                  border: InputBorder.none,
                  focusColor: Theme.of(context).colorScheme.background,
                  counterText: '',
                  filled: false,
                  isDense: true,
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 20, maxHeight: 20),
                  suffixIconConstraints:
                      const BoxConstraints(minWidth: 20, maxHeight: 20),
                  suffixIcon: widget.suffixIcon != null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 0),
                          child: InkWell(
                              onTap: widget.ontapIcon,
                              child: widget.suffixIcon!),
                        )
                      : widget.required
                          ? const Text(
                              '*',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            )
                          : null,
                  prefixIcon: widget.prefixIcon,
                  hintText: widget.hintText,
                  hintStyle:
                      widget.hintStyle ?? Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          )

          // : const SizedBox(
          //     height: 15,
          //   ),
        ],
      ),
    );
  }
}
