class PetModel {
  final String name;
  final int age;
  final String gender;
  final String about;
  final String animalType;

  PetModel({
    required this.name,
    required this.age,
    required this.gender,
    required this.about,
    required this.animalType,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "age": age,
      "gender": gender,
      "about": about,
      "animalType": animalType,
    };
  }
}