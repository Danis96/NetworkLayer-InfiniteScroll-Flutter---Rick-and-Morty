class Location {
  Location({this.name});

  Location.fromJson(dynamic json) {
    name = json['name'] as String ?? '';
  }
  String name;
}
