import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oropocket_assignment/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Top Movies',
      theme: ThemeData(
          fontFamily: GoogleFonts.getFont('Inter').fontFamily,
          primaryColor: const Color.fromARGB(255, 7, 8, 24),
          backgroundColor: const Color.fromARGB(255, 27, 28, 42),
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color.fromARGB(255, 0, 124, 255), brightness: Brightness.dark)),
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

