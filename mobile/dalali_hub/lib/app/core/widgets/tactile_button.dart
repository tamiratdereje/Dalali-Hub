import 'package:dalali_hub/constants/color_constants.dart';
import 'package:flutter/material.dart';

class TactileButton extends StatelessWidget {
  TactileButton({
    super.key,
    required String text,
    this.leadingWidget,
    this.trailingWidget,
    this.onTap,
    this.fillWidth = true,
    this.height,
    this.alignment = MainAxisAlignment.start,
    TextAlign textAlign = TextAlign.start,
  }) : textWidget = Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          textAlign: textAlign,
        );
  final Widget textWidget;

  final Widget? leadingWidget;
  final Widget? trailingWidget;
  final GestureTapCallback? onTap;
  final bool fillWidth;
  final double? height;
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fillWidth ? double.infinity : null,
      height: height ?? 64,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColor.primaryColor,
          ),
          child: Row(
            mainAxisAlignment: alignment,
            children: [
              if (leadingWidget != null) leadingWidget!,
              if (leadingWidget != null) const SizedBox(width: 8),
              textWidget,
              if (trailingWidget != null) const SizedBox(width: 8),
              if (trailingWidget != null) trailingWidget!,
            ],
          ),
        ),
      ),
    );
  }
}
