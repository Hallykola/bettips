import 'package:equatable/equatable.dart';

import "records.dart";

class Recycleruser extends Equatable {
  final List<Records?>? records;

  const Recycleruser({this.records});

  @override
  String toString() => 'Recycleruser(records: $records)';

  factory Recycleruser.fromJson(Map<String, dynamic> json) {
    return Recycleruser(
      records: (json['records'] as List<dynamic>).map((e) {
        return e == null ? null : Records.fromJson(e as Map<String, dynamic>);
      }).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'records': records!.map((e) => e!.toJson()).toList(),
    };
  }

  Recycleruser copyWith({
    List<Records?>? records,
  }) {
    return Recycleruser(
      records: records ?? this.records,
    );
  }

  @override
  List<Object> get props => [records as Object];
}
