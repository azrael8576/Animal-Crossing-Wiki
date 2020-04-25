// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Animal _$AnimalFromJson(Map<String, dynamic> json) {
  return Animal(
    id: json['id'] as String,
    name: json['name'] as String,
    name_jp: json['name_jp'] as String,
    name_en: json['name_en'] as String,
    gender: json['gender'] as String,
    personality: json['personality'] as String,
    specie: json['specie'] as String,
    birthday: json['birthday'] as String,
    catchphras: json['catchphras'] as String,
    picture: json['picture'] as String,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$AnimalToJson(Animal instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_jp': instance.name_jp,
      'name_en': instance.name_en,
      'gender': instance.gender,
      'personality': instance.personality,
      'specie': instance.specie,
      'birthday': instance.birthday,
      'catchphras': instance.catchphras,
      'picture': instance.picture,
      'image': instance.image,
    };
