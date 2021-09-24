import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'mycategorie.dart';

class Cat {
  final List<Categorie>? categories;
  Cat({
    this.categories,
  });

  Cat copyWith({
    List<Categorie>? categories,
  }) {
    return Cat(
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categories': categories?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Cat.fromMap(Map<String, dynamic> map) {
    return Cat(
      categories: List<Categorie>.from(
          map['categories']?.map((x) => Categorie.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cat.fromJson(String source) => Cat.fromMap(json.decode(source));

  @override
  String toString() => 'Cat(categories: $categories)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Cat && listEquals(other.categories, categories);
  }

  @override
  int get hashCode => categories.hashCode;
}
