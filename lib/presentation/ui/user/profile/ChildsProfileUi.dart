import 'package:flutter/material.dart';
import 'package:mamak/data/serializer/user/GetUserProfileResponse.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';

class ChildsProfileUi extends StatefulWidget {
  const ChildsProfileUi({Key? key, required this.children}) : super(key: key);
  final List<Children> children;

  @override
  State<ChildsProfileUi> createState() => _ChildsProfileUiState();
}

class _ChildsProfileUiState extends State<ChildsProfileUi>
    with TickerProviderStateMixin {
  late TabController _tabController;
  var index = 0;

  @override
  void initState() {
    _tabController = TabController(length: widget.children.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        index = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          indicator: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16.0),
                topLeft: Radius.circular(16.0),
              )),
          controller: _tabController,
          tabs: List.generate(
            widget.children.length,
            (index) => SizedBox(
              height: 40,
              child: Tab(
                child: Text(
                  widget.children[index].fullName ?? '',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          ),
        ),
        if (widget.children.isNotEmpty)
          Container(
            padding: 16.dpe,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: Row(
              children: [
                SizedBox(
                    width: 60,
                    height: 60,
                    child: CircleAvatar(backgroundColor: Colors.blue)),
                8.dph,
                Text(widget.children[index].age?.toString() ?? '')
              ],
            ),
          )
      ],
    );
  }
}
