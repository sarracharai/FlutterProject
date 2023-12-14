// info_absence_screen.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      Uri.parse('http://10.0.2.2:8081/api/absences/all'),
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
