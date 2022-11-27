import 'package:flutter/foundation.dart';
import 'package:flutter_idp_isolate/data_source/local_station_data_source.dart';
import 'package:flutter_idp_isolate/domain/station.dart';
import 'package:flutter_idp_isolate/repository/i_station_repository.dart';

const _path = 'assets/stations.json';

///
class LocalStationRepository extends IStationRepository {
  final LocalStationDataSource localStationDataSource;

  const LocalStationRepository(this.localStationDataSource);

  @override
  Future<List<Station>> getAllOnMainIsolate() async {
    final dictionaryStr = await localStationDataSource.getAll();
    return IStationRepository.decodeData(dictionaryStr).toList();
  }

  @override
  Future<List<Station>> getAllOnNewIsolate() async {
    final dictionaryStr = await localStationDataSource.getAll();
    return (await compute(IStationRepository.decodeData, dictionaryStr))
        .toList();
  }

  @override
  Future<Station> getByNameOnMainIsolate(String name) async {
    final dictionaryStr = await localStationDataSource.getAll();
    return IStationRepository.decodeData(dictionaryStr)
        .firstWhere((element) => element.name == name);
  }

  @override
  Future<Station> getByNameOnNewIsolate(String name) async {
    final dictionaryStr = await localStationDataSource.getAll();
    return (await compute(IStationRepository.decodeData, dictionaryStr))
        .firstWhere((element) => element.name == name);
  }
}
