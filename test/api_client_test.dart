import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_unit_test/api_client.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late RealApiClient apiClient;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    apiClient = RealApiClient(client: mockHttpClient);
  });

  group('RealApiClient Tests', () {
    test('getRequest performs a GET call with the correct URI', () async {
      // Arrange
      final expectedUri = Uri.parse('https://jsonplaceholder.typicode.com/test');
      when(() => mockHttpClient.get(expectedUri))
          .thenAnswer((_) async => http.Response('{"status": "ok"}', 200));

      // Act
      final response = await apiClient.getRequest('/test');

      // Assert
      expect(response.statusCode, 200);
      expect(response.body, '{"status": "ok"}');
      verify(() => mockHttpClient.get(expectedUri)).called(1);
    });
  });
}
