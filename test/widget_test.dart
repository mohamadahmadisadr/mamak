// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:feature/languages/germany.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mamak/presentation/state/formState/user/RegisterFormState.dart';
import 'package:mamak/presentation/translation.dart';
import 'package:shamsi_date/shamsi_date.dart';

void main() {
  testWidgets('date test', (WidgetTester tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();
    RegisterFormState formState = RegisterFormState();
    formState.mobile = 'email';
    expect(formState.email ?? formState.mobile, 'email');
  });
}
