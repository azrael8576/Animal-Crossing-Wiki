import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:json_annotation/json_annotation.dart';

part 'animal.g.dart';

@JsonSerializable()
class Animal {
  final String id;
  final String name;
  final String name_jp;
  final String name_en;
  final String gender;
  final String personality;
  final String specie;
  final String birthday;
  final String catchphras;
  final String picture;
  final String image;


  const Animal({this.id, this.name, this.name_jp, this.name_en, this.gender, this.personality, this.specie,
    this.birthday, this.catchphras, this.picture, this.image});

  factory Animal.fromJson(Map<String, dynamic> json) => _$AnimalFromJson(json);

  Map<String, dynamic> toJson() => _$AnimalToJson(this);

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/row/animal.json');
  }
}