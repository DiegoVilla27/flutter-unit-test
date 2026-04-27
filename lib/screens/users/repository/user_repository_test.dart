import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import '../services/api_client.dart';
import 'user_repository.dart';
import '../models/user_model.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late UserRepository userRepository;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    userRepository = UserRepository(apiClient: mockApiClient);
  });

  group('UserRepository Tests (Dio)', () {
    test('returns a User if the call completes successfully', () async {
      // Arrange
      final response = Response(
        requestOptions: RequestOptions(path: '/users/1'),
        data: {'id': 1, 'name': 'Diego Villa'},
        statusCode: 200,
      );
      
      when(() => mockApiClient.getRequest('/users/1'))
          .thenAnswer((_) async => response);

      // Act
      final user = await userRepository.getUser(1);

      // Assert
      expect(user, isA<User>());
      expect(user.id, 1);
      expect(user.name, 'Diego Villa');
      verify(() => mockApiClient.getRequest('/users/1')).called(1);
    });

    test('throws an exception if the call fails (404)', () async {
      // Arrange
      final response = Response(
        requestOptions: RequestOptions(path: '/users/2'),
        data: 'Not Found',
        statusCode: 404,
      );
      
      when(() => mockApiClient.getRequest('/users/2'))
          .thenAnswer((_) async => response);

      // Act & Assert
      expect(() => userRepository.getUser(2), throwsException);
    });
  });
}
