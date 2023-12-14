import 'package:flutter/material.dart';

import 'screen/absencescreen.dart';
import 'screen/classscreen.dart';
import 'screen/formationscreen.dart';
import 'screen/info_absence_screen.dart'
    as InfoAbsenceScreen; // Import with an alias
import 'screen/login.dart';
import 'screen/matierescreen.dart';
import 'screen/studentsscreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => Login(),
        '/students': (context) => StudentScreen(),
        '/class': (context) => ClasseScreen(),
        '/formation': (context) => FormationScreen(),
        '/matiere': (context) => MatiereScreen(),
        '/absence': (context) => AbsenceScreen(),
        '/info': (context) => InfoAbsenceScreen
            .InfoAbsenceScreen(), // Use the class with the alias
      },
    );
  }
}
