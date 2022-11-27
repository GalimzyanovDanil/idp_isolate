import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'station_model.g.dart';

/// Модель станции в справочнике/API
@immutable
@JsonSerializable()
class StationModel {
  /// Код станции
  @JsonKey(name: 'Code')
  final int code;

  /// Код-6 станции
  @JsonKey(name: 'Code 6')
  final String code6;

  /// Наименование станции
  @JsonKey(name: 'Name')
  final String name;

  /// Дефолтный конструктор
  const StationModel({
    required this.code,
    required this.code6,
    required this.name,
  });

  /// @nodoc
  factory StationModel.fromJson(Map<String, dynamic> json) {
    return _$StationModelFromJson(json);
  }

  @override
  String toString() => 'Station model: $name';

  /// @nodoc
  Map<String, dynamic> toJson() => _$StationModelToJson(this);
}

/// Декодирование JSON в модель
Future<int> fetchData(String dictionaryStr) async {
  final decodeResult = json.decode(dictionaryStr) as List<dynamic>;

  final l = decodeResult
      .map<StationModel>(
        (dynamic e) => StationModel.fromJson(e as Map<String, dynamic>),
      )
      .length;

  return l;
}
