import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:dalali_hub/app/pages/customer_home/widgets/customer_appbar.dart';
import 'package:dalali_hub/app/pages/property_filter/widgets/result_item_card.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/domain/entity/feed.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FilterResultPage extends StatelessWidget {
  final List<Feed> feed;
  const FilterResultPage({super.key, required this.feed});

  @override
  Widget build(BuildContext context) {
    return FilterResult(
      searchResults: feed,
    );
  }
}

class FilterResult extends StatefulWidget {
  final List<Feed> searchResults;
  const FilterResult({super.key, required this.searchResults});

  @override
  State<FilterResult> createState() => _FilterResultState();
}

class _FilterResultState extends State<FilterResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomerAppBar(title: "Search Results"),
      body: Padding(
        padding: EdgeInsets.only(
          left: 6.6.w,
          right: 6.6.w,
          bottom: 5.6.h,
          top: 2.6.h,
        ),
        child: GridView.builder(
          itemCount: widget.searchResults.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) => ResultItemCard(
            imgUrl: "https://picsum.photos/200/300",
            title: "Title",
            color: AppColors.doctor,
            onTap: () {
              context.push(AppRoutes.propertyDetail, extra: {
                "feed": widget.searchResults[index],
                "category": widget.searchResults[index].category,
              });
            },
            feed: widget.searchResults[index],
          ),
        ),
      ),
    );
  }
}
