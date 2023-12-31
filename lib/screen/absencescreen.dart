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
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoAbsenceScreen(),
                  ),
                );
              },
              child: Text('Informations sur les Absences'),
            ),
          ],
        ),
      ),
    );
  }

  bool validateInput() {
    if (etudiantIdCtrl.text.isEmpty ||
        matiereIdCtrl.text.isEmpty ||
        absenceNbCtrl.text.isEmpty) {
      print('Veuillez remplir tous les champs.');
      return false;
    }

    // Add additional validation as needed
    // For example, you might check if the input is a valid number

    return true;
  }

  Future<void> addAbsence() async {
    try {
      if (!validateInput()) {
        return;
      }

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
    } catch (e) {
      // Gérer l'exception (afficher un message, logger, etc.)
      print('Erreur lors de la requête HTTP : $e');
    }
  }
}

class InfoAbsenceScreen extends StatefulWidget {
  @override
  _InfoAbsenceScreenState createState() => _InfoAbsenceScreenState();
}

class _InfoAbsenceScreenState extends State<InfoAbsenceScreen> {
  TextEditingController etudiantIdCtrl = TextEditingController();
  TextEditingController matiereIdCtrl = TextEditingController();
  List<AbsenceInfo> absencesInfos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informations sur les Absences'),
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
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                await getAbsencesInfo();
              },
              child: Text('Voir les Informations sur les Absences'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Informations sur les Absences:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: absencesInfos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Absence ${index + 1}'),
                    subtitle: Text(
                        'Date: ${absencesInfos[index].date}, Nb: ${absencesInfos[index].absenceNb}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getAbsencesInfo() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8081/api/absences/info'),
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'etudiantId': int.parse(etudiantIdCtrl.text),
        'matiereId': int.parse(matiereIdCtrl.text),
      }),
    );

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      print("JSON data received: $data");

      if (data is List) {
        List<AbsenceInfo> absences =
            data.map((json) => AbsenceInfo.fromJson(json)).toList();
        setState(() {
          absencesInfos = absences;
        });
      } else {
        throw Exception(
            "No 'absences' data found or data structure is invalid");
      }
    } else {
      throw Exception("Failed to load absences");
    }
  }
}

class AbsenceInfo {
  final String date;
  final double absenceNb;

  AbsenceInfo({required this.date, required this.absenceNb});

  factory AbsenceInfo.fromJson(Map<String, dynamic> json) {
    return AbsenceInfo(
      date: json['date'],
      absenceNb: json['absenceNb'],
    );
  }
}
