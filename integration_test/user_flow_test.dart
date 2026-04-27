import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_unit_test/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-End Test', () {
    testWidgets('Full app flow: Counter -> Navigation -> Fetch User', (tester) async {
      // 1. Start the app
      app.main();
      await tester.pumpAndSettle();

      // 2. Verify initial state of the counter
      expect(find.text('0'), findsOneWidget);

      // 3. Increment the counter
      final Finder fab = find.byTooltip('Increment');
      await tester.tap(fab);
      await tester.pumpAndSettle();
      expect(find.text('1'), findsOneWidget);

      // 4. Navigate to Users Screen
      final Finder usersButton = find.byIcon(Icons.people);
      await tester.tap(usersButton);
      await tester.pumpAndSettle();

      // Verify we are on the Users screen
      expect(find.text('Users API'), findsOneWidget);
      expect(find.text('No user loaded'), findsOneWidget);

      // 5. Fetch a User (Real API call in E2E)
      final Finder fetchButton = find.text('Fetch User (ID: 1)');
      await tester.tap(fetchButton);
      
      // We need to wait for the network call to finish
      // In E2E, we use pumpAndSettle with a large timeout or repeated pumps
      await tester.pump(); // Start loading
      await tester.pump(const Duration(seconds: 2)); // Wait for real network
      await tester.pumpAndSettle();

      // 6. Verify result (Since it's a real call to JSONPlaceholder, it should work)
      // Note: Leanne Graham is the name of user ID 1 in JSONPlaceholder
      expect(find.text('Leanne Graham'), findsOneWidget);
    });
  });
}
