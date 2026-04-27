import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_unit_test/screens/home/home_screen.dart';
import 'package:flutter_unit_test/screens/users/users_screen.dart';
import 'package:flutter_unit_test/screens/users/repository/user_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  testWidgets('HomeScreen should increment counter', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('HomeScreen should navigate to UsersScreen', (WidgetTester tester) async {
    final mockUserRepository = MockUserRepository();
    
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/users',
          builder: (context, state) => UsersScreen(userRepository: mockUserRepository),
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(
      routerConfig: router,
    ));

    // Tap the people icon to navigate
    await tester.tap(find.byIcon(Icons.people));
    await tester.pumpAndSettle();

    // Verify we are on the Users screen
    expect(find.text('Users API'), findsOneWidget);
  });
}
