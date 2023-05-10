import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mamak/data/serializer/assessment/QuestionsResponse.dart';
import 'package:mamak/presentation/ui/main/TextFormFieldHelper.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/viewModel/assessments/AssessmentsViewModel.dart';

class AssessmentItemUi extends StatefulWidget {
  AssessmentItemUi({
    Key? key,
    required this.item, required this.index,
  }) : super(key: key);

  final Question? item;
  final int index;
  Uint8List? content;

  @override
  State<AssessmentItemUi> createState() => _AssessmentItemUiState();
}

class _AssessmentItemUiState extends State<AssessmentItemUi> {
  int? selectedItem;

  @override
  void initState() {
    if (widget.item?.questionPicture != null &&
        widget.item?.questionPicture?.content != null) {
      getContent(widget.item!.questionPicture!.content!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        4.dpv,
        if (widget.content != null)
          ClipRRect(
            borderRadius: 16.bRadius,
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 150.0,
                child: Image.memory(
                  widget.content!,
                  fit: BoxFit.contain,
                )),
          ),
        8.dpv,
        Container(
          padding: 16.dpe,
          margin: 4.dpe,
          decoration: BoxDecoration(
            borderRadius: 8.bRadius,
            color: Colors.grey.shade50,
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Text('${widget.index}.${widget.item?.questionTitle ?? ''}'),
        ),
        Container(
          padding: 16.dpe,
          margin: 4.dpe,
          decoration: BoxDecoration(
            borderRadius: 8.bRadius,
            color: Colors.blue.shade50,
            border: Border.all(color: Colors.blue.shade100),
          ),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.item?.options?.length,
            itemBuilder: (context, index) => SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: widget.item?.options
                            ?.elementAt(index)
                            .optionId
                            ?.toString() ==
                        selectedItem?.toString(),
                    onChanged: (value) {
                      context.read<AssessmentsViewModel>().onOptionSelected(
                            widget.item?.questionId?.toString(),
                            value == true
                                ? widget.item?.options?.elementAt(index)
                                : null,
                          );
                      setState(() {
                        selectedItem =
                            widget.item?.options?.elementAt(index).optionId;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      widget.item?.options?[index].optionTitle ?? '',
                      style: context.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        8.dpv,
        SizedBox(
          height: 100,
          child: TextFormFieldHelper(
            hint: getDescriptionText(selectedItem ?? 0),
            keyboardType: TextInputType.text,
            label: getDescriptionText(selectedItem ?? 0),
            onChangeValue: (value) {
              context
                  .read<AssessmentsViewModel>()
                  .onChangeDesc(widget.item?.questionId?.toString(), value);
            },
            expand: true,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }

  String getDescriptionText(int index) {
    if (index == -1) return 'پاسخ';
    if (index == 0 || index == 1) {
      return 'هدفگذاری';
    }
    return 'راهکار';
  }

  Future<Uint8List> getBase64FromContent(String content) async =>
      base64Decode(widget.item!.questionPicture!.content!);

  void getContent(String content) async {
    widget.content = await getBase64FromContent(content);
    setState(() {});
  }
}
