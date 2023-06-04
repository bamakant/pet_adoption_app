import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pet_adoption_app/feature/details/widgets/details.dart';
import 'package:pet_adoption_app/feature/home/notifier/home_notifier.dart';
import 'package:pet_adoption_app/feature/home/widgets/home.dart';
import 'package:pet_adoption_app/feature/home/widgets/pet_widget.dart';
import 'package:pet_adoption_app/utils/data.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Verify navigation from Home to Details page',
      (WidgetTester tester) async {
    //Mocked home notifier
    final notifier = HomeNotifier(MockBuildContext());

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider.value(
          value: notifier,
          child: const Home(),
        ),
        routes: {
          '/details': (_) => Details(pets[0]),
        },
      ),
    );

    //tapping first pet item
    await tester.tap(find.byType(PetWidget).first);
    await tester.pumpAndSettle();

    //verifying that we have navigated to the Details page
    expect(find.byType(Details), findsOneWidget);

    //verifying the details of the pet on the Details page
    expect(find.text(pets[0]['name']), findsOneWidget);
    expect(find.text(pets[0]['age']), findsOneWidget);
    expect(find.text(pets[0]['price']), findsOneWidget);

    //tap on back arrow button to go back to home screen
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
    await tester.pumpAndSettle();

    //verifying that we have returned to the Home screen
    expect(find.byType(Home), findsOneWidget);
  });
}

class MockBuildContext extends Mock implements BuildContext {}
