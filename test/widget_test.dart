import 'package:dog_dashboard/features/dog_dashboard/presentation/pages/dog_dashboard_page.dart';
import 'package:dog_dashboard/features/dog_dashboard/presentation/widgets/breed_filters.dart';
import 'package:dog_dashboard/features/dog_dashboard/presentation/widgets/image_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Dog Dashboard App Test', (WidgetTester tester) async {
    // Build your app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: DogDashboardPage()));

    // Wait for the initial loading to complete.
    await tester.pumpAndSettle();

    // Verify that the initial UI elements are displayed.
    expect(find.text('Dog Dashboard'), findsOneWidget);
    expect(find.byType(BreedFilters), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Interact with the dropdowns
    await tester.tap(find.byKey(const Key('breed_dropdown')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Random image by breed'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('sub_breed_dropdown')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Select Sub Breed'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Some Sub Breed'));
    await tester.pumpAndSettle();

    // Interact with the "Show Results" button
    await tester.tap(find.text('Show Results'));
    await tester.pumpAndSettle();

    // Verify that the images are displayed
    expect(find.text('Random image by breed and sub breed'), findsOneWidget);
    expect(find.byType(ImageList), findsOneWidget);

  });
}
