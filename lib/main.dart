import 'package:flutter/material.dart';
import 'package:flutter_final_year_project/routes.dart';
import 'package:flutter_final_year_project/screens/get_started_screen.dart';
import 'package:flutter_final_year_project/screens/notes_list_screen.dart';
import 'package:flutter_final_year_project/screens/notes_saving_screen.dart';
import 'package:flutter_final_year_project/screens/sign_in_screen.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
        // Define the default font family.
        fontFamily: 'Georgia',
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: RouteGenerator.getStartedPage,
      debugShowCheckedModeBanner: false,
      home: const NotesListScreen(),
    );
  }
}
