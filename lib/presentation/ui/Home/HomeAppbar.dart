import 'package:flutter/cupertino.dart';
import 'package:mamak/presentation/ui/main/MamakLogo.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    margin: const EdgeInsets.only(right: 50.0),
      child: Padding(
        padding: 8.dpeh,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const MamakLogo(width: 100),
            Row(
              children: [
                FutureBuilder(
                  future: getUserFullName,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.hasData
                          ? snapshot.data?.toString() ?? ''
                          : 'نام کاربر',
                    );
                  },
                ),
                8.dph,
                const Icon(CupertinoIcons.person_alt_circle)
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<String> get getUserFullName async =>
      GetIt.I.get<LocalSessionImpl>().getData(UserSessionConst.fullName);
}
