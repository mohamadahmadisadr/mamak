import 'package:flutter/material.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MyLoader.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/viewModel/file/DownloadFileViewModel.dart';

class DownloadFileDialog extends StatefulWidget {
  const DownloadFileDialog({Key? key, required this.fileDataId}) : super(key: key);
  final String fileDataId;

  @override
  State<DownloadFileDialog> createState() => _DownloadFileDialogState();
}

class _DownloadFileDialogState extends State<DownloadFileDialog> {
  late DownloadFileViewModel viewModel;


  @override
  void initState() {
    viewModel = DownloadFileViewModel(AppState.idle);
    viewModel.downloadFile(widget.fileDataId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0)),
      insetPadding: 16.dpe,
      alignment: Alignment.center,
      child: CubitProvider(
        create: (context) => viewModel,
        builder: (bloc, state) {
          return Container(
            decoration: BoxDecoration(borderRadius: 16.bRadius),
            child: Padding(
              padding: 16.dpe,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const MyLoader(radius: 20),
                  8.dph,
                  const Expanded(child: Text('درحال دریافت اطلاعات'))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
