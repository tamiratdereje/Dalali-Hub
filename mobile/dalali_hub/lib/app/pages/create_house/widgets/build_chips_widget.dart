import 'package:dalali_hub/app/utils/colors.dart';
import 'package:flutter/material.dart';

class BuildChip extends StatefulWidget {
  final String label;
  final Function onDeleted;
  const BuildChip(
      {super.key,
      required this.label,
      required this.onDeleted,
      });

  @override
  State<BuildChip> createState() => _BuildChipState();
}

class _BuildChipState extends State<BuildChip> {
  @override
  Widget build(BuildContext context) {
    return InputChip(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      selected: false,
      deleteIcon: const Icon(
        Icons.close,
        color: AppColors.nauticalCreatures,
      ),
      onDeleted: (){
        widget.onDeleted(widget.label);
      },
      labelPadding: const EdgeInsets.all(8),
      label: Text(
        widget.label,
        style: const TextStyle(
          color: AppColors.nauticalCreatures,
        ),
      ),
      backgroundColor: Colors.grey[200],
      padding: const EdgeInsets.all(8),
    );
  }
}
