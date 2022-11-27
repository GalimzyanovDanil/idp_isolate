import 'package:dio/dio.dart';

const _uri =
    'https://c39c09cb-cd65-4244-ba81-19c490f58c06.mock.pstmn.io/stations';

class RemoteStationDataSource {
  final _dio = Dio();

  Future<String> fetchAll() async {
    final response = await _dio.getUri(Uri.parse(_uri));
    return response.data as String;
  }
}
