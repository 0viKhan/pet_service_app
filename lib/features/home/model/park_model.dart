class ParkModel {
  final int id;
  final String name;
  final String location;
  final String image;

  ParkModel({
    required this.id,
    required this.name,
    required this.location,
    required this.image,
  });

  factory ParkModel.fromJson(Map<String, dynamic> json) {
    return ParkModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      location: json['location'] ?? "",
      image: json['image'] ?? "",
    );
  }
}