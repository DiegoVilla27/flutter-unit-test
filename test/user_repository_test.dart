import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_unit_test/api_client.dart';
import 'package:flutter_unit_test/user_repository.dart';
import 'package:flutter_unit_test/user_model.dart';

// 1. Create a Mock class
class MockApiClient extends Mock implements ApiClient {}

void main() {
  late UserRepository userRepository;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    userRepository = UserRepository(apiClient: mockApiClient);
  });

  group('UserRepository Advanced Tests', () {
    test('returns a User if the call completes successfully', () async {
      // Arrange
      when(() => mockApiClient.getRequest('/users/1'))
          .thenAnswer((_) async => http.Response('{"id": 1, "name": "Diego Villa"}', 200));

      // Act
      final user = await userRepository.getUser(1);

      // Assert
      expect(user, isA<User>());
      expect(user.id, 1);
      expect(user.name, 'Diego Villa');
      
      // Verify the mock was called exactly once with the correct path
      verify(() => mockApiClient.getRequest('/users/1')).called(1);
    });

    test('throws an exception if the call fails (404)', () async {
      // Arrange
      when(() => mockApiClient.getRequest('/users/2'))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // Act & Assert
      expect(() => userRepository.getUser(2), throwsException);
    });

    test('throws an exception if the network fails', () async {
      // Arrange
      when(() => mockApiClient.getRequest(any()))
          .thenThrow(Exception('Network Error'));

      // Act & Assert
      expect(() => userRepository.getUser(1), throwsException);
    });
  });
}
