import 'package:dalali_hub/app/utils/colors.dart';
import 'package:flutter/material.dart';

class ChipsBuilder extends StatefulWidget {
  final String label;
  const ChipsBuilder(
      {super.key,
      required this.label,
      });

  @override
  State<ChipsBuilder> createState() => _ChipsBuilderState();
}

class _ChipsBuilderState extends State<ChipsBuilder> {
  @override
  Widget build(BuildContext context) {
    return Chip(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      labelPadding: const EdgeInsets.all(8),
      label: Text(
        widget.label,
        style: const TextStyle(
          color: AppColors.nauticalCreatures,
        ),
      ),

      backgroundColor: Colors.white,
      padding: const EdgeInsets.all(8),
    );
  }
}
