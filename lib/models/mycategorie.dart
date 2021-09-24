import 'dart:convert';

class Categorie {
  int? id;
  String? name;
  String? tags;
  String? description;
  Categorie({
    this.id = 0,
    this.name,
    this.tags,
    this.description,
  });

  Categorie copyWith({
    int? id,
    String? name,
    String? tags,
    String? description,
  }) {
    return Categorie(
      id: id ?? this.id,
      name: name ?? this.name,
      tags: tags ?? this.tags,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'tags': tags,
      'description': description,
    };
  }

  factory Categorie.fromMap(Map<String, dynamic> map) {
    return Categorie(
      id: map['id'],
      name: map['name'],
      tags: map['tags'],
      description: map['description'],
    );
  }
//  Categorie.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['teama'];
//     tags = json['teamb'];
//     description = json['teamalast'];

//   }

  String toJson() => json.encode(toMap());

  factory Categorie.fromJson(String source) =>
      Categorie.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Categorie(id: $id, name: $name, tags: $tags, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Categorie &&
        other.id == id &&
        other.name == name &&
        other.tags == tags &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ tags.hashCode ^ description.hashCode;
  }
}
