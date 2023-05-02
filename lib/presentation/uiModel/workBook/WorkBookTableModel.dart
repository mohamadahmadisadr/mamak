import 'package:sprintf/sprintf.dart';

class WorkBookTableModel {
  final String id, count;
  final int previousThree, three;

  WorkBookTableModel({
    required this.id,
    required this.previousThree,
    required this.three,
    required this.count,
  });

  String get value =>
      sprintf('%s از %s', [(three + previousThree).toString(), count]);
}
