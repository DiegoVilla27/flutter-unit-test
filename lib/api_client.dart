import 'package:http/http.dart' as http;

abstract class ApiClient {
  Future<http.Response> getRequest(String path);
}

class RealApiClient implements ApiClient {
  final http.Client client;
  final String baseUrl;

  RealApiClient({required this.client, this.baseUrl = 'https://jsonplaceholder.typicode.com'});

  @override
  Future<http.Response> getRequest(String path) async {
    return await client.get(Uri.parse('$baseUrl$path'));
  }
}
