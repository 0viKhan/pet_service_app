class ParkModel {
  final int id;
  final String name;
  final String location;
  final String image;
  final String link;

  ParkModel({
    required this.id,
    required this.name,
    required this.location,
    required this.image,
    required this.link,
  });

  factory ParkModel.fromJson(Map<String, dynamic> json) {
    return ParkModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      location: json['location'] ?? "",
      image: json['image'] ?? "",
      link: json['link'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "location": location,
      "link": link,
    };
  }
}