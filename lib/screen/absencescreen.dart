// absence_screen.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AbsenceScreen extends StatefulWidget {
  @override
  _AbsenceScreenState createState() => _AbsenceScreenState();
}

class _AbsenceScreenState extends State<AbsenceScreen> {
  TextEditingController etudiantIdCtrl = TextEditingController();
  TextEditingController matiereIdCtrl = TextEditingController();
  TextEditingController absenceNbCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saisie des Absences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: etudiantIdCtrl,
              decoration: InputDecoration(labelText: 'ID de l\'étudiant'),
            ),
            TextField(
              controller: matiereIdCtrl,
              decoration: InputDecoration(labelText: 'ID de la matière'),
            ),
            TextField(
              controller: absenceNbCtrl,
              decoration: InputDecoration(labelText: 'Nombre d\'absences'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                await addAbsence();
              },
              child: Text('Ajouter Absence'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addAbsence() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8081/api/absences/add'),
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'etudiantId': int.parse(etudiantIdCtrl.text),
        'matiereId': int.parse(matiereIdCtrl.text),
        'absenceNb': double.parse(absenceNbCtrl.text),
      }),
    );

    if (response.statusCode == 200) {
      // Absence ajoutée avec succès
      print('Absence ajoutée avec succès');
    } else {
      // Gestion des erreurs, affichez un message approprié
      print('Erreur lors de l\'ajout de l\'absence');
    }
  }
}
