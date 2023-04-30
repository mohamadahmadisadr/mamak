import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/data/serializer/user/GetUserProfileResponse.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MamakScaffold.dart';
import 'package:mamak/presentation/ui/main/MyLoader.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/presentation/viewModel/user/ProfileViewModel.dart';

import 'ChildsProfileUi.dart';

class ProfileUi extends StatelessWidget {
  const ProfileUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => ProfileViewModel(AppState.idle),
      builder: (bloc, state) {
        return MamakScaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned(
                        right: 0.0,
                        left: 0.0,
                        top: 0.0,
                        child: Container(
                          height: 200.0,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade500,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.elliptical(
                                MediaQuery.of(context).size.width,
                                100.0,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: 8.dpe,
                                margin: 16.dpe,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 1)),
                                child: Text(
                                  'کودک خود را بشناسید',
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.titleMedium
                                      ?.copyWith(
                                          color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue.shade500,
                                  border: Border.all(
                                      color: Colors.white, width: 4.0)),
                              child: bloc.selectedImage == null
                                  ? const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 80,
                                    )
                                  : SizedBox(
                                      width: 90,
                                      height: 90,
                                      child: ClipRRect(
                                        borderRadius: 45.bRadius,
                                        child: Image.memory(
                                          bloc.selectedImage!
                                              .getFileFormBase64(),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: InkWell(
                                onTap: bloc.pickImage,
                                borderRadius: 30.bRadius,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  width: 30,
                                  padding: 4.dpe,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: bloc.uploadState.isLoading
                                      ? const MyLoader(radius: 7.0)
                                      : const Icon(
                                          Icons.edit,
                                          size: 20,
                                        ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                4.dpv,
                Text(
                  bloc.userState.isSuccess
                      ? (bloc.userState.getData as GetUserProfileResponse)
                              .fullName ??
                          ''
                      : '',
                  style: context.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      Text(
                        'فرزندان',
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      8.dpv,
                      ConditionalUI<GetUserProfileResponse>(
                        state: bloc.userState,
                        onSuccess: (userData) => userData
                                    .children?.isNotEmpty ==
                                true
                            ? ChildsProfileUi(children: userData.children ?? [])
                            : const Text('هنوز هیچ فرزندی ثبت نشده است'),
                        skeleton: Container(
                          height: 200,
                          margin: 8.dpe,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: 16.bRadius,
                          ),
                        ),
                      ),
                      8.dpv,
                      TextButton.icon(
                          onPressed: bloc.gotoAddChildPage,
                          icon: const Icon(CupertinoIcons.add_circled_solid),
                          label: const Text('اضافه کردن فرزند')),
                      8.dpv,
                      Text(
                        'رسید پرداخت',
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      4.dpv,
                      const FactorsTableUi(),
                      const Divider(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FactorsTableUi extends StatelessWidget {
  const FactorsTableUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: DataTable(
        columns: List.generate(
          4,
          (index) => DataColumn(
            label: index == 3
                ? const SizedBox()
                : const Text(
                    'ردیف',
                  ),
          ),
        ),
        rows: List.generate(
          2,
          (index) => DataRow(
            cells: List.generate(
              4,
              (index) => DataCell(
                index == 3 ? const FactorDetailButton() : const Text('1234'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FactorDetailButton extends StatelessWidget {
  const FactorDetailButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: TextButton.icon(
        style: ElevatedButton.styleFrom(
          side: const BorderSide(color: Colors.grey),
        ),
        onPressed: () {},
        icon: const Icon(Icons.remove_red_eye, color: Colors.grey),
        label: const Text(
          'مشاهده فاکتور',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
