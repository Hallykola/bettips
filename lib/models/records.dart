import 'package:equatable/equatable.dart';

class Records extends Equatable {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final String? password;
  final int? coin;
  final String? location;
  final String? description;
  final String? joined;
  final String? token;

  const Records({
    this.id,
    this.name,
    this.username,
    this.email,
    this.password,
    this.coin,
    this.location,
    this.description,
    this.joined,
    this.token,
  });

  @override
  String toString() {
    return 'Records(id: $id, name: $name, username: $username, email: $email, password: $password, coin: $coin, location: $location, description: $description, joined: $joined, token: $token)';
  }

  factory Records.fromJson(Map<String, dynamic> json) {
    return Records(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      coin: json['coin'] as int,
      location: json['location'] as String,
      description: json['description'] as String,
      joined: json['joined'] as String,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      'coin': coin,
      'location': location,
      'description': description,
      'joined': joined,
      'token': token,
    };
  }

  Map<String, dynamic> regtoJson() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  Records copyWith({
    int? id,
    String? name,
    String? username,
    String? email,
    String? password,
    int? coin,
    String? location,
    String? description,
    String? joined,
    String? token,
  }) {
    return Records(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      coin: coin ?? this.coin,
      location: location ?? this.location,
      description: description ?? this.description,
      joined: joined ?? this.joined,
      token: token ?? this.token,
    );
  }

  @override
  List<Object> get props {
    return [
      id as int,
      name as String,
      username as String,
      email as String,
      password as String,
      coin as String,
      location as String,
      description as String,
      joined as String,
      token as String,
    ];
  }
}
