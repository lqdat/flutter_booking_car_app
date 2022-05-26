class PlaceStep {
  final double distance;
  final List<dynamic> steps;

  PlaceStep(this.distance, this.steps);

  static List<PlaceStep> fromJson(Map<String, dynamic> json) {
    print("parse data");
    List<PlaceStep> rs = [];

    var results = json['routes'] as List;

    var _step = results[0]['geometry']['coordinates'] as List;
    var p = PlaceStep(results[0]['distance'], _step);
    rs.add(p);

    return rs;
  }
}
