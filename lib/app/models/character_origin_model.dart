class Origin {
  Origin({this.name});

  Origin.fromJson(dynamic json) {
    name = json['name'] as String ?? '';
  }

  String name;
}
