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
import 'package:mamak/presentation/translation.dart';
import 'package:shamsi_date/shamsi_date.dart';

void main() {
  testWidgets('date test', (WidgetTester tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();
    var date = DateFormat('yyyy/mm/dd').parse('1402/7/5');
    var gDate = Jalali(date.year,date.month,date.day).toDateTime().toString();
    var formattedDate = DateFormat.yMMMd().parse(gDate);
    expect(formattedDate, '27/9/2023');
  });
}
