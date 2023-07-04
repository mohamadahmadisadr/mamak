import 'package:flutter/material.dart';
import 'package:mamak/data/serializer/child/ChildsResponse.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MyLoader.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/viewModel/child/GetChildsViewModel.dart';

class SegmentChildUi extends StatelessWidget {
  const SegmentChildUi(
      {Key? key,
      required this.onSelectChild,
      required this.state,
      this.selectedChild})
      : super(key: key);
  final Function(ChildsItem) onSelectChild;
  final AppState state;
  final ChildsItem? selectedChild;

  @override
  Widget build(BuildContext context) {
    return ConditionalUI<List<ChildsItem>>(
      skeleton: MyLoader(),
      state: state,
      onSuccess: (childs) {
        return Padding(
          padding: 8.dpe,
          child: SegmentedButton<ChildsItem>(
            segments: childs
                .map((e) => ButtonSegment<ChildsItem>(
                    value: e,
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(e.childFirstName ?? ''),
                    )))
                .toList(),
            selected: <ChildsItem>{selectedChild!},
            onSelectionChanged: (newChild) {
              onSelectChild.call(newChild.first);
            },
          ),
        );
      },
    );
  }
}
