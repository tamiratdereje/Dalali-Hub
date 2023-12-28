import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dalali_hub/app/core/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CarouselSliderWithDots extends StatefulWidget {
  const CarouselSliderWithDots(
      {super.key,
      this.items = const [
        'https://images.unsplash.com/photo-1688920556232-321bd176d0b4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80',
        'https://images.unsplash.com/photo-1689085781839-2e1ff15cb9fe?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80',
        'https://images.unsplash.com/photo-1688980034676-7e8ee518e75a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=735&q=80',
      ],
      required this.curIndex});

  final List<String> items;
  final int curIndex;

  @override
  State<CarouselSliderWithDots> createState() => _CarouselSliderWithDotsState();
}

class _CarouselSliderWithDotsState extends State<CarouselSliderWithDots> {
  late CarouselController controller;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = CarouselController();
    setState(() {
      currentIndex = widget.curIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(8.h),
          child: Padding(
            padding: EdgeInsets.only(left: 3.6.w, right: 3.6.w),
            child: DalaliAppBar(
              leadingButtonAction: () => {Navigator.pop(context)},
            ),
          )),
      body: Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              CarouselSlider(
                carouselController: controller,
                items: widget.items
                    .map(
                      (item) => Image.network(
                        item,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: 400,
                  initialPage: currentIndex,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
              Positioned(
                bottom: 8.0,
                child: DotsIndicator(
                  dotsCount: widget.items.length,
                  position: currentIndex,
                  onTap: (index) {
                    controller.animateToPage(index);
                  },
                  decorator: DotsDecorator(
                    color: Colors.white,
                    activeColor: Colors.amber,
                    size: const Size.square(12.0),
                    activeSize: const Size(24.0, 12.0),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
