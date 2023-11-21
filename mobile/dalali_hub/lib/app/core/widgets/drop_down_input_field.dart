import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

@immutable
class AppDropDownInputField extends StatefulWidget {
  final List<String> items;
  final String label;
  final void Function(String) onChanged;
  const AppDropDownInputField(
      {super.key,
      required this.items,
      required this.label,
      required this.onChanged});

  @override
  State<AppDropDownInputField> createState() => _AppDropDownInputFieldState();
}

class _AppDropDownInputFieldState extends State<AppDropDownInputField> {
  late String selectedValue;
  @override
  void initState() {
    super.initState();
    selectedValue = widget.items[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: inputFieldLabelStyle),
        SizedBox(height: 2.h),
        DropdownButtonFormField(
            value: selectedValue,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.ultimateGray,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.doctor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
            ),
            items: widget.items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedValue = value.toString();
                widget.onChanged(selectedValue);
              });
            }),
      ],
    );
  }
}
