import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tp70/entities/absence.dart';

class AbsenceService {
  static const String apiUrl = "http://10.0.2.2:8081/absence";

  Future<List<Absence>> getAllAbsences() async {
    final response = await http.get(Uri.parse("$apiUrl/all"));

    if (response.statusCode == 200) {
      Iterable data = json.decode(response.body);
      List<Absence> absences =
          data.map((json) => Absence.fromJson(json)).toList();
      return absences;
    } else {
      throw Exception('Failed to load absences');
    }
  }

  static Future<void> addAbsence(Absence absence) async {
    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8081/absence/add"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(absence.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to add absence. Server returned ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding absence: $e');
      throw e;
    }
  }

  static Future<void> updateAbsence(Absence absence) async {
    final response = await http.put(
      Uri.parse("$apiUrl/update"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(absence),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update absence');
    }
  }

  Future<void> deleteAbsence(int id) async {
    final response = await http.delete(
      Uri.parse("$apiUrl/delete?id=$id"),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete absence');
    }
  }
}
