import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:flutter_unit_test/screens/users/services/api_client.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late RealApiClient apiClient;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    apiClient = RealApiClient(dio: mockDio);
  });

  group('RealApiClient Tests (Dio)', () {
    test('getRequest performs a GET call with the correct path', () async {
      // Arrange
      final response = Response(
        requestOptions: RequestOptions(path: '/test'),
        data: {'status': 'ok'},
        statusCode: 200,
      );
      
      when(() => mockDio.get('/test'))
          .thenAnswer((_) async => response);

      // Act
      final result = await apiClient.getRequest('/test');

      // Assert
      expect(result.statusCode, 200);
      expect(result.data, {'status': 'ok'});
      verify(() => mockDio.get('/test')).called(1);
    });
  });
}
