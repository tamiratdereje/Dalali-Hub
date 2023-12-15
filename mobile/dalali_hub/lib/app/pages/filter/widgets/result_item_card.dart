import 'package:flutter/material.dart';

class ResultItemCard extends StatelessWidget {
  const ResultItemCard({
    Key? key,
    required this.imgUrl,
    required this.title,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  final String imgUrl;
  final String title;
  final Color color;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () => onTap(),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          
        ),
      ),
    );
  }
}
