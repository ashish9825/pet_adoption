import 'package:equatable/equatable.dart';

class Pet extends Equatable {
  final int id;
  final String image;
  final String name;
  final String gender;
  final String category;
  final String breed;
  final int price;
  final String currency;
  final int ageInYears;
  final String owner;
  final DateTime? adoptedAt;

  const Pet(
      {required this.id,
      required this.image,
      required this.name,
      required this.gender,
      required this.category,
      required this.breed,
      required this.price,
      required this.currency,
      required this.ageInYears,
      required this.owner,
      this.adoptedAt});

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
      id: json['id'] as int,
      image: json['image'] as String,
      name: json['name'] as String,
      gender: json['gender'] as String,
      category: json['category'] as String,
      breed: json['breed'] as String,
      price: json['price'] as int,
      currency: json['currency'] as String,
      ageInYears: json['age_in_years'] as int,
      owner: json['owner'] as String,
      adoptedAt: json['adopted_at'] != null
          ? DateTime.parse(json['adopted_at'])
          : null);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'image': image,
        'name': name,
        'gender': gender,
        'category': category,
        'breed': breed,
        'price': price,
        'currency': currency,
        'age_in_years': ageInYears,
        'owner': owner,
        'adopted_at': adoptedAt?.toIso8601String()
      };

  @override
  List<Object?> get props => [
        id,
        image,
        name,
        gender,
        category,
        breed,
        price,
        currency,
        ageInYears,
        owner,
        adoptedAt
      ];
}
