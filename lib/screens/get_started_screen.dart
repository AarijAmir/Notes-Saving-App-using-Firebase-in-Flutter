import 'package:flutter/material.dart';

import '../routes.dart';
import '../widgets/button.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
              height: screenHeight,
              'assets/images/book.png',
              fit: BoxFit.fitWidth),
          Align(
            alignment: Alignment.bottomCenter,
            child: TitleWithButton(
                titleData: 'Save Your Daily Notes',
                height: screenHeight * 0.32,
                width: screenWidth,
                containerColor: Colors.white,
                callback: () {
                  Navigator.of(context).pushNamed(RouteGenerator.signInPage);
                }),
          )
        ],
      ),
    );
  }
}
