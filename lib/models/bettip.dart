import 'package:equatable/equatable.dart';

import "tip.dart";

class Bettip extends Equatable {
  final List<Tip>? tip;

  const Bettip({this.tip});

  @override
  String toString() => 'Bettip(tip: $tip)';

  factory Bettip.fromJson(Map<String, dynamic> json) {
    return Bettip(
      tip: (json['records'] as List<Tip>).map((e) {
        return e == null ? null : Tip.fromJson(e as Map<String, dynamic>);
      }).toList() as List<Tip>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tip': tip?.map((e) => e.toJson()).toList(),
    };
  }

  Bettip copyWith({
    List<Tip>? tip,
  }) {
    return Bettip(
      tip: tip ?? this.tip,
    );
  }

  @override
  List<Object> get props => [tip as List<Object>];
}
