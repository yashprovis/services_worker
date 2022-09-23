import 'dart:convert';

Worker workerFromJson(String str) => Worker.fromJson(json.decode(str));

String workerToJson(Worker data) => json.encode(data.toJson());

class Worker {
  Worker({
    required this.id,
    required this.name,
    required this.image,
    required this.email,
    required this.phone,
    required this.desc,
    required this.workingCity,
    required this.workingExperience,
    required this.workingSpecialisation,
    required this.workingTags,
    required this.hourlyRate,
    required this.gender,
    required this.ratings,
    this.avgRating,
  });

  final String id;
  final String name;
  final String image;

  final String email;
  final String phone;
  final String desc;
  final String workingCity;
  final int workingExperience;
  final String workingSpecialisation;
  final List workingTags;
  final int hourlyRate;
  final String gender;
  final List ratings;
  final double? avgRating;

  factory Worker.fromJson(Map<String, dynamic> json) => Worker(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        email: json["email"],
        phone: json["phone"],
        desc: json["desc"],
        workingCity: json["workingCity"],
        workingExperience: json["workingExperience"],
        workingSpecialisation: json["workingSpecialisation"],
        workingTags: json["workingTags"] ?? [],
        hourlyRate: json["hourlyRate"],
        gender: json["gender"],
        ratings: json["ratings"] ?? [],
        avgRating: json["ratingAvg"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "email": email,
        "phone": phone,
        "desc": desc,
        "workingCity": workingCity,
        "workingExperience": workingExperience,
        "workingSpecialisation": workingSpecialisation,
        "workingTags": workingTags,
        "hourlyRate": hourlyRate,
        "gender": gender,
        "ratings": ratings,
      };
}
