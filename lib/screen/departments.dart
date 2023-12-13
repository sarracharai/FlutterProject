/*
import 'package:flutter/material.dart';


import '../service/classeservice.dart';

class DepartmentsScreen extends StatefulWidget {
  @override
  _DepartmentsScreenState createState() => _DepartmentsScreenState();
}

class _DepartmentsScreenState extends State<DepartmentsScreen> {
  int _selectedDepartment = 0;
  dynamic _selectedClass;

  Future<void> fetchClassByDepartment(int departmentId) async {
    dynamic result = await findClassesByDepartmentNumber(departmentId);
    setState(() {
      _selectedClass = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Departments'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<int>(
              value: _selectedDepartment,
              onChanged: (int? newValue) {
                setState(() {
                  _selectedDepartment = newValue!;
                  fetchClassByDepartment(_selectedDepartment);
                });
              },
              items: [
                DropdownMenuItem<int>(
                  value: 0,
                  child: Text('IT'),
                ),
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text('Mechanical'),
                ),
                DropdownMenuItem<int>(
                  value: 2,
                  child: Text('Electrical'),
                ),
                DropdownMenuItem<int>(
                  value: 3,
                  child: Text('Management'),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            _selectedClass != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected Class:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Name: ${_selectedClass[0]}'),
                      // Text('Code: ${_selectedClass['codClass'] ?? 'N/A'}'),
                    ],
                  )
                : Text('Select a department to see the class'),
          ],
        ),
      ),
    );
  }
}
*/
