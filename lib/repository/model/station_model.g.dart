// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationModel _$StationModelFromJson(Map<String, dynamic> json) => StationModel(
      code: json['Code'] as int,
      code6: json['Code 6'] as String,
      name: json['Name'] as String,
    );

Map<String, dynamic> _$StationModelToJson(StationModel instance) =>
    <String, dynamic>{
      'Code': instance.code,
      'Code 6': instance.code6,
      'Name': instance.name,
    };
