class Tip {
  int? id;
  String? teama;
  String? teamb;
  String? teamalast;
  String? teamblast;
  String? teamaodd;
  String? teambodd;
  String? drawodd;
  String? description;
  String? tags;
  String? date;

  Tip({
    this.id = 0,
    this.teama,
    this.teamb,
    this.teamalast,
    this.teamblast,
    this.teamaodd,
    this.teambodd,
    this.drawodd,
    this.description,
    this.tags,
    this.date = "",
  });

  Tip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teama = json['teama'];
    teamb = json['teamb'];
    teamalast = json['teamalast'];
    teamblast = json['teamblast'];
    teamaodd = json['teamaodd'];
    teambodd = json['teambodd'];
    drawodd = json['drawodd'];
    description = json['description'];
    tags = json['tags'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id.toString();
    data['teama'] = this.teama;
    data['teamb'] = this.teamb;
    data['teamaodd'] = this.teamaodd;
    data['teambodd'] = this.teambodd;
    data['drawodd'] = this.drawodd;
    data['teamalast'] = this.teamalast;
    data['teamblast'] = this.teamblast;
    data['description'] = this.description;
    data['tags'] = this.tags;
    //data['date'] = this.date;

    return data;
  }
}
