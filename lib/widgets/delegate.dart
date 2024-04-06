import 'package:flutter/material.dart';

class DelegateForLoginSignUpScreens extends SliverPersistentHeaderDelegate {
  final Color backgroundColor;
  final String title;
  final String secondTitle;
  final double height;
  final double width;
  final void Function() callback;

  DelegateForLoginSignUpScreens(
      {required this.backgroundColor,
      required this.title,
      required this.height,
      required this.width,
      required this.secondTitle,
      required this.callback});

  @override
  double get maxExtent => height * 0.25;

  @override
  double get minExtent => height * 0.15;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
      color: backgroundColor,
      height: height,
      width: width,
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.only(top: height * 0.1, left: height * 0.04),
          child: Column(
            children: [
              Text(
                title.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: (height * 0.04) - (shrinkOffset * 0.2)),
              ),
              SizedBox(height: height * 0.01),
              GestureDetector(
                onTap: callback,
                child: Text(
                  secondTitle.toString(),
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: (height * 0.03) - (shrinkOffset * 0.2)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
