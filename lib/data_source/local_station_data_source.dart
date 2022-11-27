import 'package:flutter/services.dart';

const _path = 'assets/stations.json';

class LocalStationDataSource {
  Future<String> getAll() => rootBundle.loadString(_path);
}
