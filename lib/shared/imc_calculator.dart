import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/calculation_page.dart';

class IMCCalculator extends StatelessWidget {
  const IMCCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const CalculationPage(),
    );
  }
}
