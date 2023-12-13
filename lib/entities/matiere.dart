class Matiere {
  int? matiereId;
  String matiereName;

  Matiere(this.matiereName, [this.matiereId]);

  Matiere.withId(this.matiereId, this.matiereName); // Named constructor

  factory Matiere.fromJson(Map<String, dynamic> json) {
    return Matiere(
      json['matiereId'],
      json['matiereName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'matiereId': matiereId,
      'matiereName': matiereName,
    };
  }

  @override
  String toString() {
    return matiereName;
  }
}
