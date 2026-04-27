import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_unit_test/screens/users/models/user_model.dart';
import 'package:flutter_unit_test/screens/users/repository/user_repository.dart';
import 'package:flutter_unit_test/screens/users/users_screen.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
  });

  testWidgets('UsersScreen should display user data on success', (WidgetTester tester) async {
    // Arrange
    final user = User(id: 1, name: 'Diego Villa');
    when(() => mockUserRepository.getUser(1)).thenAnswer((_) async => user);

    // Act
    await tester.pumpWidget(MaterialApp(
      home: UsersScreen(userRepository: mockUserRepository),
    ));

    expect(find.text('No user loaded'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); // Start loading
    
    // Sometimes pump() can be fast, so we'll just check if it finishes
    await tester.pumpAndSettle(); 

    // Assert
    expect(find.text('Diego Villa'), findsOneWidget);
    expect(find.text('ID: 1'), findsOneWidget);
  });

  testWidgets('UsersScreen should display error message on failure', (WidgetTester tester) async {
    // Arrange
    when(() => mockUserRepository.getUser(1)).thenThrow(Exception('Error'));

    // Act
    await tester.pumpWidget(MaterialApp(
      home: UsersScreen(userRepository: mockUserRepository),
    ));

    await tester.tap(find.byIcon(Icons.download));
    await tester.pumpAndSettle();

    // Assert
    expect(find.textContaining('Error loading user'), findsOneWidget);
  });
}
