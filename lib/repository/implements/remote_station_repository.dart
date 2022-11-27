import 'package:flutter/foundation.dart';
import 'package:flutter_idp_isolate/data_source/remote_station_data_source.dart';
import 'package:flutter_idp_isolate/domain/station.dart';
import 'package:flutter_idp_isolate/repository/i_station_repository.dart';

///
class RemoteStationRepository extends IStationRepository {
  final RemoteStationDataSource remoteStationDataSource;

  const RemoteStationRepository(this.remoteStationDataSource);

  @override
  Future<List<Station>> getAllOnMainIsolate() async {
    final dictionaryStr = await remoteStationDataSource.fetchAll();
    return IStationRepository.decodeData(dictionaryStr).toList();
  }

  @override
  Future<List<Station>> getAllOnNewIsolate() async {
    final dictionaryStr = await remoteStationDataSource.fetchAll();
    return (await compute(IStationRepository.decodeData, dictionaryStr))
        .toList();
  }

  @override
  Future<Station> getByNameOnMainIsolate(String name) async {
    final dictionaryStr = await remoteStationDataSource.fetchAll();
    return IStationRepository.decodeData(dictionaryStr)
        .firstWhere((element) => element.name == name);
  }

  @override
  Future<Station> getByNameOnNewIsolate(String name) async {
    final dictionaryStr = await remoteStationDataSource.fetchAll();
    return (await compute(IStationRepository.decodeData, dictionaryStr))
        .firstWhere((element) => element.name == name);
  }
}
