import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../routes.dart';
import '../widgets/button.dart';
import '../widgets/delegate.dart';
import '../widgets/inputdecoration_for_form_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late GlobalKey<FormState> _globalFormKey;
  late TextEditingController _userNameTextEditingController;
  late TextEditingController _passwordTextEditingController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _globalFormKey = GlobalKey<FormState>();
    _userNameTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _userNameTextEditingController.addListener(() {
      print(_userNameTextEditingController.text);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _userNameTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isEyePressed = true;
    Icon hideEye = const Icon(Icons.visibility_off);
    Icon unHideEye = const Icon(Icons.visibility);
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: DelegateForLoginSignUpScreens(
                    callback: () {
                      Navigator.of(context)
                          .pushNamed(RouteGenerator.signUpPage);
                    },
                    height: size.height,
                    width: size.width,
                    backgroundColor: Colors.transparent,
                    title: 'Sign In',
                    secondTitle: 'Sign Up'),
                floating: true,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(size.height * 0.05),
                        child: Container(
                          color: Colors.white,
                          height: size.height * 0.7,
                          width: size.width * 0.9,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.05,
                                right: size.width * 0.05),
                            child: Form(
                              key: _globalFormKey,
                              child: Column(
                                children: [
                                  const Spacer(flex: 26),
                                  Expanded(
                                    flex: 15,
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller:
                                          _userNameTextEditingController,
                                      decoration:
                                          InputDecorationOfField.decoration(
                                        size: size,
                                        label: 'Enter Username',
                                        prefixIcon: const Icon(
                                          Icons.person,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(flex: 2),
                                  Expanded(
                                    flex: 15,
                                    child: TextFormField(
                                      controller:
                                          _passwordTextEditingController,
                                      keyboardType: TextInputType.number,
                                      obscureText: isEyePressed,
                                      decoration:
                                          InputDecorationOfField.decoration(
                                              prefixIcon: const Icon(Icons.lock,
                                                  color: Colors.orange),
                                              label: 'Enter 4 Digit Key',
                                              size: size),
                                    ),
                                  ),
                                  const Spacer(flex: 12),
                                  const Spacer(flex: 10),
                                  Expanded(
                                    flex: 10,
                                    child: ButtonForProceeding(
                                        callback: () {
                                          // Navigator.of(context).pushNamed(
                                          //     RouteGenerator.signUpPage);
                                          Navigator.of(context).pushNamed(
                                              RouteGenerator.notesList);
                                        },
                                        buttonColor: Colors.orange,
                                        text: 'Sign In'),
                                  ),
                                  const Spacer(
                                    flex: 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
