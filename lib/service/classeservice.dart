import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tp70/entities/classe.dart';

Future getAllClasses() async {
  Response response =
      await http.get(Uri.parse("http://10.0.2.2:8081/class/all"));
  return jsonDecode(response.body);
}

Future<List<Classe>> getClassesByDepartment(String department) async {
  final Uri uri = Uri.parse(
      'http://10.0.2.2:8081/class/byDepartment?department=$department');

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    List<Classe> classes = data
        .map((item) => Classe(
              item['nbreEtud'],
              item['nomClass'],
              item['codClass'],
            ))
        .toList();

    return classes;
  } else {
    throw Exception('Échec de chargement des classes par département');
  }
}
/*
Future<List<dynamic>> findClassesByDepartmentNumber(
    int departmentNumber) async {
  try {
    http.Response response = await http
        .get(Uri.parse("http://10.0.2.2:8081/class/finbyid/$departmentNumber"));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      print("JSON data received: $data");
      return data;
    } else if (response.statusCode == 404) {
      print("Classes not found for department number: $departmentNumber");
      return [];
    } else {
      //
      print("Request failed with status: ${response.statusCode}");
      throw Exception("Failed to load class data");
    }
  } catch (e) {
    print("Exception occurred: $e");
    throw Exception("Failed to fetch class data: $e");
  }
}

 */

Future deleteClass(int id) {
  return http.delete(Uri.parse("http://10.0.2.2:8081/class/delete?id=${id}"));
}

Future addClass(Classe classe) async {
  Response response = await http.post(
      Uri.parse("http://10.0.2.2:8081/class/add"),
      headers: {"Content-type": "Application/json"},
      body: jsonEncode(<String, dynamic>{
        "nomClass": classe.nomClass,
        "nbreEtud": classe.nbreEtud
      }));

  return response.body;
}

Future updateClasse(Classe classe) async {
  Response response =
      await http.put(Uri.parse("http://10.0.2.2:8081/class/update"),
          headers: {"Content-type": "Application/json"},
          body: jsonEncode(<String, dynamic>{
            "codClass": classe.codClass,
            "nomClass": classe.nomClass,
            "nbreEtud": classe.nbreEtud
          }));

  return response.body;
}
