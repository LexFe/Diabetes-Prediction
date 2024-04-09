import 'dart:convert';

class PredictsModel {
  final int? id;
  final String? name;
  final int? age;
  final int? pregnancies;
  final int? glucose;
  final int? bloodPressure;
  final int? skinthickness;
  final int? insulin;
  final double? diabetespedigreefunction;
  final double? bmi;
  final String? predict;

  PredictsModel({
    this.id,
    this.name,
    this.age,
    this.pregnancies,
    this.glucose,
    this.bloodPressure,
    this.skinthickness,
    this.insulin,
    this.diabetespedigreefunction,
    this.bmi,
    this.predict,
  });

  factory PredictsModel.fromRawJson(String str) =>
      PredictsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PredictsModel.fromJson(Map<String, dynamic> json) => PredictsModel(
        id: json["id"],
        name: json["name"],
        age: json["age"],
        pregnancies: json["pregnancies"],
        glucose: json["glucose"],
        bloodPressure: json["bloodPressure"],
        skinthickness: json["skinthickness"],
        insulin: json["insulin"],
        diabetespedigreefunction: json["diabetespedigreefunction"],
        bmi: json["bmi"],
        predict: json["predict"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "age": age,
        "pregnancies": pregnancies,
        "glucose": glucose,
        "bloodPressure": bloodPressure,
        "skinthickness": skinthickness,
        "insulin": insulin,
        "diabetespedigreefunction": diabetespedigreefunction,
        "bmi": bmi,
        "predict": predict,
      };
}
