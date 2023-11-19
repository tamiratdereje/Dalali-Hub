import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppDropDown extends StatefulWidget {
  AppDropDown(
      {super.key,
      this.leadingWidget,
      required this.dropDownValues,
      this.selectedValue,
      this.onChanged,
      this.label,
      required this.labelStyle,
      this.itemBuilder,
      this.useItemBuilderForSelectedValue = false,
      this.itemsIcon = const [],
      this.isString = false,
      required this.hint});

  final Widget? leadingWidget;
  final List<String> dropDownValues;
  String? selectedValue;
  final void Function(String?)? onChanged;
  final String? label;
  TextStyle labelStyle = bodyTextStyle;
  final Widget Function(String)? itemBuilder;
  final bool useItemBuilderForSelectedValue;
  final List<String> itemsIcon;
  final bool isString;
  final String hint;
  @override
  State<AppDropDown> createState() => _AppDropDownState();
}

class _AppDropDownState extends State<AppDropDown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: widget.labelStyle,
          ),
          const SizedBox(height: 8)
        ],
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 1.4.h),
          decoration: BoxDecoration(
            color: AppColors.doctor,
            borderRadius: BorderRadius.all(Radius.circular(2.6.w)),
          ),
          height: 65,
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              items: widget.dropDownValues
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Container(
                          decoration:  BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.black.withOpacity(0.5),
                                width: 2,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              if (widget.itemsIcon.isNotEmpty) ...[
                                SvgPicture.asset(
                                  widget.itemsIcon[
                                      widget.dropDownValues.indexOf(e)],
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(width: 8),
                              ],
                              if (!widget.isString) ...[
                                widget.itemBuilder!(e),
                              ],
                              if (widget.isString) ...[
                                Text(
                                  e,
                                  style: bodyTextStyle.copyWith(
                                      color: AppColors.doctor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ))
                  .toList(),
              value: widget.selectedValue,
              customButton: (widget.selectedValue != null)
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 65,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (!widget.useItemBuilderForSelectedValue) ...[
                              widget.leadingWidget ?? const SizedBox(),
                              const SizedBox(width: 16),
                              Expanded(
                                  child: Text(widget.selectedValue!,
                                      style: bodyTextStyle))
                            ],
                            if (widget.useItemBuilderForSelectedValue) ...[
                              Expanded(
                                  child: widget
                                      .itemBuilder!(widget.selectedValue!))
                            ],
                            const Icon(
                              Icons.keyboard_arrow_down,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        Text(
                          widget.hint,
                          style: bodyTextStyle,
                        ),
                        const Expanded(child: SizedBox()),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                        )
                      ],
                    ),
              dropdownStyleData: DropdownStyleData(
                padding: const EdgeInsets.all(0),
                scrollPadding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.black.withOpacity(0.5),
                    width: 2,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.07),
                      blurRadius: 2,
                      offset: Offset(.8, .8),
                    ),
                  ],
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 70,
              ),
              onChanged: (String? value) {
                if (widget.onChanged != null) {
                  widget.onChanged!(value);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
