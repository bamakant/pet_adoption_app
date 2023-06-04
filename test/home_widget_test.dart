import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pet_adoption_app/feature/home/notifier/home_notifier.dart';
import 'package:pet_adoption_app/feature/home/widgets/home.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Verify entering text on Search Field at Home screen',
      (WidgetTester tester) async {
    final notifier = HomeNotifier(MockBuildContext());

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider.value(
          value: notifier,
          child: const Home(),
        ),
      ),
    );

    //Verify that the Search Field widget is displayed
    expect(find.byKey(const Key('searchField')), findsOneWidget);

    //Verify that the Pet List widget is displayed
    expect(find.byKey(const Key('petList')), findsOneWidget);

    //enter text in the search field
    await tester.enterText(find.byKey(const Key('searchField')), 'boss');

    //Triggering the onChange callback as it not getting
    //triggered during testing
    notifier.onSearchTextChange('boss');

    //Verify that the search text has been updated in the notifier
    expect(notifier.searchTextController.text, 'boss');
  });
}

class MockBuildContext extends Mock implements BuildContext {}
