import 'package:bettips/models/mycategorie.dart';

class CatResponse {
  int? totalResults;
  List<Categorie>? results;

  CatResponse.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      results = new List<Categorie>.empty(growable: true);
      json['records'].forEach((v) {
        results!.add(new Categorie.fromMap(v));
      });
      totalResults = results!.length;
      print(totalResults.toString());
    } else {
      print('result is empty');
    }
  }
}
