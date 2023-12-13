import 'package:flutter/material.dart';
import 'package:tp70/entities/matiere.dart';

import '../../service/matiereservice.dart';

class MatiereDialog extends StatefulWidget {
  final Function()? notifyParent;
  Matiere? matiere;

  MatiereDialog({
    Key? key,
    @required this.notifyParent,
    this.matiere,
    Matiere? selectedMatiere,
  }) : super(key: key);

  @override
  State<MatiereDialog> createState() => _MatiereDialogState();
}

class _MatiereDialogState extends State<MatiereDialog> {
  TextEditingController nameMat = TextEditingController();

  String title = "Ajouter Matiere";
  bool modif = false;

  late int idMatiere;

  @override
  void initState() {
    super.initState();
    if (widget.matiere != null) {
      modif = true;
      title = "Modifier matiere";
      nameMat.text = widget.matiere!.matiereName;
      idMatiere = widget.matiere!.matiereId!;
    }
  }

  Future<void> addMatiere(Matiere matiere) async {
    Matiere newMatiere = Matiere(matiere.matiereName);
    await MatiereService().addMatiere(newMatiere);
    print("Adding Matiere: ${newMatiere.matiereName}");
    widget.notifyParent!(); // Notify the parent using the callback
    setState(() {}); // Refresh the UI to reflect the new data
  }

  Future<void> updateMatiere(Matiere matiere) async {
    await MatiereService().updateMatiere(matiere);
    print("Updating Matiere: ${matiere.matiereName}, ID: ${matiere.matiereId}");
    widget.notifyParent!(); // Notify the parent using the callback
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text(title),
            TextFormField(
              controller: nameMat,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "Champs est obligatoire";
                }
                return null;
              },
              decoration: const InputDecoration(labelText: "nom"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (modif == false) {
                  await addMatiere(Matiere(nameMat.text));
                } else {
                  await updateMatiere(Matiere.withId(idMatiere, nameMat.text));
                }
                widget.notifyParent!();
                Navigator.pop(context);
              },
              child: const Text(" Ajouter "),
            ),
          ],
        ),
      ),
    );
  }
}
