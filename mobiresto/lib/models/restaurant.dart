import 'package:mobiresto/models/district.dart';

class Restaurants {
  int id;
  String name;
  String owner;
  int rating;
  String district;
  String sector;
  String image;
  String contact;
  String pricerange;
  String description;

  Restaurants({
    required this.id,
    required this.name,
    required this.owner,
    required this.rating,
    required this.district,
    required this.sector,
    required this.image,
    required this.contact,
    required this.pricerange,
    required this.description,
  });
  factory Restaurants.fromJson(Map<String, dynamic> json) {
    return Restaurants(
      id: json['id'],
      name: json['name'],
      owner: json['owner'],
      rating: json['rating'],
      district: json['district'],
      sector: json['sector'],
      image:json['image'],
      contact: json['contact'],
      pricerange: json['pricerange'],
      description: json['description'],
    );
  }
}
