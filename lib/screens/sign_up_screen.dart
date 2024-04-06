import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../routes.dart';
import '../widgets/button.dart';
import '../widgets/delegate.dart';
import '../widgets/inputdecoration_for_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late GlobalKey<FormState> _globalFormKey;
  late TextEditingController _userNameTextEditingController;
  late TextEditingController _passwordTextEditingController;
  late TextEditingController _confirmPasswordTextEditingController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _globalFormKey = GlobalKey<FormState>();
    _userNameTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _confirmPasswordTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _userNameTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _confirmPasswordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: DelegateForLoginSignUpScreens(
                    height: size.height,
                    width: size.width,
                    backgroundColor: Colors.transparent,
                    callback: () {
                      Navigator.of(context)
                          .pushNamed(RouteGenerator.signInPage);
                    },
                    title: 'Sign Up',
                    secondTitle: 'Sign In'),
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
                                      controller:
                                          _userNameTextEditingController,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Username Required';
                                        }
                                        if ((!value.contains('@'))) {
                                          return 'Email Must Contain @';
                                        }
                                        if (value.length < 8) {
                                          return 'Email Should Be Of 8 Letters';
                                        }
                                        return null;
                                      },
                                      decoration:
                                          InputDecorationOfField.decoration(
                                              label: 'Enter Username',
                                              size: size),
                                    ),
                                  ),
                                  const Spacer(flex: 2),
                                  Expanded(
                                    flex: 15,
                                    child: TextFormField(
                                      controller:
                                          _passwordTextEditingController,
                                      decoration:
                                          InputDecorationOfField.decoration(
                                              label: 'Enter 4 Digit Key',
                                              size: size),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Password Required';
                                        }
                                        if (value.length > 4 ||
                                            value.length < 4) {
                                          return 'Password Should Be Of 4 Digits';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const Spacer(flex: 2),
                                  Expanded(
                                    flex: 15,
                                    child: TextFormField(
                                        validator: (String? value) {
                                          if (_passwordTextEditingController
                                                  .text !=
                                              value) {
                                            return 'Password Not Matched';
                                          }
                                          return null;
                                        },
                                        controller:
                                            _confirmPasswordTextEditingController,
                                        decoration:
                                            InputDecorationOfField.decoration(
                                                label: 'Confirm 4 Digit Key',
                                                size: size)),
                                  ),
                                  const Spacer(flex: 10),
                                  Expanded(
                                    flex: 10,
                                    child: ButtonForProceeding(
                                        callback: () {
                                          if (_globalFormKey.currentState!
                                              .validate()) {
                                            // If the form is valid, display a snackbar. In the real world,
                                            // you'd often call a server or save the information in a database.
                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(
                                            //   const SnackBar(
                                            //       content:
                                            //           Text('Processing Data')),
                                            // );
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    RouteGenerator.signInPage);
                                          }
                                        },
                                        buttonColor: Colors.orange,
                                        text: 'Sign Up'),
                                  ),
                                  const Spacer(
                                    flex: 5,
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
