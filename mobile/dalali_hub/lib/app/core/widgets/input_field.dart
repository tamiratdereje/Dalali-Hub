import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppInputField extends StatefulWidget {
  const AppInputField(
      {super.key,
      this.hint,
      this.keyboardType,
      this.controller,
      this.label,
      this.obscureText = false,
      this.validator,
      this.prefixIcon,
      this.suffixIcon,
      this.onChanged,
      this.height = 72,
      this.alignment = TextAlign.start,
      this.labelStyle,
      this.hintStyle,
      this.enableSuggestions = true,
      this.maxLine = 1,
      this.minLine = 1});

  final Widget? prefixIcon;
  final String? hint;
  final String? label;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final double height;
  final TextAlign alignment;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final bool enableSuggestions;
  final int maxLine;
  final int minLine;

  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  bool? obscureText;

  @override
  Widget build(BuildContext context) {
    obscureText ??= widget.obscureText;
    return FormField<String>(
      validator: widget.validator,
      initialValue: widget.controller?.text,
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label != null) ...[
              Text(
                widget.label!,
                style: inputFieldLabelStyle,
              ),
              SizedBox(height: 1.h)
            ],
            SizedBox(
              width: double.infinity,
              height: widget.height,
              child: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  TextField(
                    enableSuggestions: widget.enableSuggestions,
                    cursorColor: AppColors.ultimateGray,
                    keyboardType: widget.keyboardType,
                    controller: widget.controller,
                    obscureText: obscureText!,
                    textAlign: widget.alignment,
                    decoration: InputDecoration(
                      
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 2.h),
                        prefixIcon: widget.prefixIcon != null
                            ? Padding(
                                padding: EdgeInsets.all(1.w),
                                child: widget.prefixIcon)
                            : null,
                        prefixIconConstraints: BoxConstraints(
                            minWidth: 0,
                            minHeight: 0,
                            maxHeight: widget.height),
                        filled: true,
                        fillColor: AppColors.doctor,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        hintText: widget.hint,
                        hintStyle: widget.hintStyle,
                        suffixIcon: widget.obscureText == true
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText!;
                                  });
                                },
                                icon: Icon(
                                  obscureText == true
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                              )
                            : widget.suffixIcon),
                    onChanged: (value) {
                      state.didChange(value);
                      widget.onChanged?.call(value);
                    },
                    maxLines: widget.maxLine,
                    minLines: widget.minLine,
                  ),
                ],
              ),
            ),
             Offstage(
              offstage: !state.hasError,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                  child: Text(
                    state.errorText ?? "",
                    style: inputFieldLabelMinStyle.copyWith(color: AppColors.errorColor.withOpacity(0.8)),
                  ),
                ),
              ),
            ),

          ],
        );
      },
    );
  }
}
