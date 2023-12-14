import 'package:dalali_hub/app/pages/filter/widgets/result_item_card.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FilterResultPage extends StatelessWidget {
  const FilterResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FilterResult();
  }
}

class FilterResult extends StatefulWidget {
  const FilterResult({super.key});

  @override
  State<FilterResult> createState() => _FilterResultState();
}

class _FilterResultState extends State<FilterResult> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: GridView.builder(
          itemCount: 20,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) => ResultItemCard(
            imgUrl: "https://picsum.photos/200/300",
            title: "Title",
            color: AppColors.doctor,
            onTap: () {},
          ),),
      ),
    );
  }
}