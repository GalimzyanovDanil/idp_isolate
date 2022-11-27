import 'dart:convert';

import 'package:flutter_idp_isolate/domain/station.dart';
import 'package:flutter_idp_isolate/repository/model/station_model.dart';

///
abstract class IStationRepository {
  const IStationRepository();

  Future<List<Station>> getAllOnMainIsolate();

  Future<List<Station>> getAllOnNewIsolate();

  Future<Station> getByNameOnMainIsolate(String name);

  Future<Station> getByNameOnNewIsolate(String name);

  /// Маппер из полученных моделей в доменную область
  static Station mapToDomain(StationModel model) =>
      Station(code: model.code, name: model.name);

  /// Декодирование
  static Iterable<Station> decodeData(String dictionaryStr) {
    final decodeResult = json.decode(dictionaryStr) as List<dynamic>;

    return decodeResult
        .map<StationModel>(
          (dynamic e) => StationModel.fromJson(e as Map<String, dynamic>),
        )
        .map(mapToDomain);
  }
}
