import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tp70/entities/matiere.dart';

class MatiereService {
  static List<Matiere> matieres = [
    Matiere('Mathematics', 1),
    Matiere('Science', 2),
    // Ajoutez plus de matières au besoin
  ];

  static Function? onMatiereAdded;

  static Future<List<Matiere>> getAllMatieres() async {
    await Future.delayed(Duration(seconds: 2));
    return matieres;
  }

  Future<String> updateMatiere(Matiere matiere) async {
    try {
      Response response = await http.put(
        Uri.parse("http://10.0.2.2:8081/matiere/update"),
        headers: {
          "Content-type": "Application/json",
        },
        body: jsonEncode(<String, dynamic>{
          "matiereId": matiere.matiereId,
          "matiereName": matiere.matiereName,
        }),
      );

      return response.body;
    } catch (e) {
      print('Error updating matiere: $e');
      throw e;
    }
  }

  Future addMatiere(Matiere matiere) async {
    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8081/matiere/add"),
        headers: {
          "Content-type": "application/json",
        },
        body: jsonEncode(<String, dynamic>{
          "matiereName": matiere.matiereName,
        }),
      );

      if (response.statusCode == 200) {
        print('Matiere added successfully');
        if (onMatiereAdded != null) {
          onMatiereAdded!();
        }
      } else {
        throw Exception('Failed to add matiere');
      }
    } catch (e) {
      print('Error adding matiere: $e');
      throw e;
    }
  }

  static Future<void> deleteMatiere(int matiereId) async {
    await Future.delayed(Duration(seconds: 1));
    matieres.removeWhere((matiere) => matiere.matiereId == matiereId);
  }
}
