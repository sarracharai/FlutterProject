import 'package:flutter/material.dart';

import '../../entities/absence.dart';
import '../../service/absenceservice.dart';

class AbsenceDialog extends StatefulWidget {
  final Function()? notifyParent;
  Absence? absence;

  AbsenceDialog({Key? key, required this.notifyParent, this.absence})
      : super(key: key);

  @override
  _AbsenceDialogState createState() => _AbsenceDialogState();
}

class _AbsenceDialogState extends State<AbsenceDialog> {
  TextEditingController etudiantCtrl = TextEditingController();
  TextEditingController matiereCtrl = TextEditingController();
  TextEditingController nbAbsenceCtrl = TextEditingController();

  String title = "Ajouter Absence";
  bool isEditing = false;

  late int idAbsence;

  @override
  void initState() {
    super.initState();
    if (widget.absence != null) {
      isEditing = true;
      title = "Modifier Absence";
      etudiantCtrl.text = widget.absence!.etudiantId.toString();
      matiereCtrl.text = widget.absence!.matiereId.toString();
      nbAbsenceCtrl.text = widget.absence!.absenceNb.toString();
      idAbsence = widget.absence!.absenceId!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text(title),
            TextFormField(
              controller: etudiantCtrl,
              decoration: const InputDecoration(labelText: "Étudiant ID"),
            ),
            TextFormField(
              controller: matiereCtrl,
              decoration: const InputDecoration(labelText: "Matière ID"),
            ),
            TextFormField(
              controller: nbAbsenceCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Nombre d'absences"),
            ),
            ElevatedButton(
              onPressed: () async {
                Absence absence = Absence(
                  etudiantId: int.parse(etudiantCtrl.text),
                  matiereId: int.parse(matiereCtrl.text),
                  absenceNb: double.parse(nbAbsenceCtrl.text),
                  date: DateTime.now(),
                );

                if (isEditing) {
                  absence.absenceId = idAbsence;
                  await AbsenceService.updateAbsence(absence);
                } else {
                  await AbsenceService.addAbsence(absence);
                }

                widget.notifyParent!();
              },
              child: const Text("Ajouter/Modifier"),
            ),
          ],
        ),
      ),
    );
  }
}
