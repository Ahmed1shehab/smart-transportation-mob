// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'students_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudentImpl _$$StudentImplFromJson(Map<String, dynamic> json) =>
    _$StudentImpl(
      id: json['_id'] as String,
      name: json['name'] as String,
      ssn: json['ssn'] as String,
      image: json['image'] as String,
      disabilities: (json['disabilities'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      phone: json['phone'] as String? ?? '-',
      address: json['address'] as String? ?? '-',
    );

Map<String, dynamic> _$$StudentImplToJson(_$StudentImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'ssn': instance.ssn,
      'image': instance.image,
      'disabilities': instance.disabilities,
      'phone': instance.phone,
      'address': instance.address,
    };
