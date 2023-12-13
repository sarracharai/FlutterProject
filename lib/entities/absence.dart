class Absence {
  int? absenceId;
  int etudiantId;
  int matiereId;
  double absenceNb;
  DateTime date;

  Absence({
    this.absenceId,
    required this.etudiantId,
    required this.matiereId,
    required this.absenceNb,
    required this.date,
  });

  // Deserialize Absence object from JSON
  factory Absence.fromJson(Map<String, dynamic> json) {
    return Absence(
      absenceId: json['absenceId'],
      etudiantId: json['etudiantId'],
      matiereId: json['matiereId'],
      absenceNb: json['absenceNb'],
      date: DateTime.parse(json['date']),
    );
  }

  // Add a method to convert the Absence object to JSON
  Map<String, dynamic> toJson() {
    return {
      'absenceId': absenceId,
      'etudiantId': etudiantId,
      'matiereId': matiereId,
      'absenceNb': absenceNb,
      'date': date.toIso8601String(),
    };
  }
}
