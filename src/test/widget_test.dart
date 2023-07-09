// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pet_adoption/main.dart';
import 'package:pet_adoption/pages/details/widgets/pet_attribute_widget.dart';
import 'package:pet_adoption/pages/home/widgets/theme_switch_button.dart';

void main() {
  testWidgets('PedoApp Widgets Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PetAdoApp());

    // Test case to verify if the Searchfield to search the pets is giving correct results
    var textField = find.byType(TextFormField);
    expect(textField, findsOneWidget);
    await tester.enterText(textField, 'Yukon');
    expect(find.text('Yukon'), findsOneWidget);

    var iconButton = find.byType(IconButton);
    expect(iconButton, findsOneWidget);
    await tester.tap(iconButton);
    await tester.pump();
  });
}
