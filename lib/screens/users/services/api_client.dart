import 'package:dio/dio.dart';

abstract class ApiClient {
  Future<Response> getRequest(String path);
}

class RealApiClient implements ApiClient {
  final Dio dio;

  RealApiClient({required this.dio});

  @override
  Future<Response> getRequest(String path) async {
    return await dio.get(path);
  }
}
