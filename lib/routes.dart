import 'package:flutter/material.dart';
import 'package:flutter_final_year_project/screens/get_started_screen.dart';
import 'package:flutter_final_year_project/screens/notes_list_screen.dart';
import 'package:flutter_final_year_project/screens/notes_saving_screen.dart';
import 'package:flutter_final_year_project/screens/sign_in_screen.dart';
import 'package:flutter_final_year_project/screens/sign_up_screen.dart';
import 'package:flutter_final_year_project/transition/slide_transition.dart';

class RouteGenerator {
  static const String getStartedPage = '/';
  static const String signInPage = '/login';
  static const String signUpPage = '/signup';
  static const String notesList = '/notes-List';
  static const String notesDetail = '/notes-detail';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case getStartedPage:
        return SlideTransitionPageRoute(
            page: const GetStartedScreen(),
            transition: Transition.bottom,
            duration: const Duration(seconds: 1));
      case signInPage:
        return SlideTransitionPageRoute(
            page: const SignInScreen(),
            transition: Transition.left,
            duration: const Duration(milliseconds: 500));
      case signUpPage:
        return SlideTransitionPageRoute(
          settings: settings,
          page: const SignUpScreen(),
          transition: Transition.right,
          duration: const Duration(milliseconds: 500),
        );
      case notesList:
        return SlideTransitionPageRoute(
          settings: settings,
          page: const NotesListScreen(),
          transition: Transition.bottom,
          duration: const Duration(milliseconds: 500),
        );
      case notesDetail:
        return SlideTransitionPageRoute(
          settings: settings,
          page: const NotesSavingScreen(),
          transition: Transition.top,
          duration: const Duration(milliseconds: 500),
        );
      default:
        throw 'Error!!! Something went wrong';
    }
  }
}
