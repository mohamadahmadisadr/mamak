import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/config/uiCommon/MyTheme.dart';
import 'package:mamak/data/serializer/assessment/QuestionsResponse.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MamakScaffold.dart';
import 'package:mamak/presentation/ui/main/MamakTitle.dart';
import 'package:mamak/presentation/ui/main/TextFormFieldHelper.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/uiModel/QuestionModel.dart';
import 'package:mamak/presentation/viewModel/assessments/AssessmentsViewModel.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';

import '../main/MyLoader.dart';

class AssessmentsUi extends StatelessWidget {
  const AssessmentsUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => AssessmentsViewModel(AppState.idle),
      builder: (bloc, state) {
        return MamakScaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: 8.dpe,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(32.0),
                        bottomRight: Radius.circular(32.0),
                      ),
                      color: MyTheme.purple,
                    ),
                    child: Padding(
                      padding: 16.dpe,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const MamakTitle(title: 'کارگاه های من'),
                          16.dpv,
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(32.0),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: SizedBox(
                              height: 45,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                padding: 8.dpe,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 8.0),
                                    child: Text(
                                        bloc.getAssessmentModelAsList[index]),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const VerticalDivider(width: 1);
                                },
                                itemCount: bloc.getAssessmentModelAsList.length,
                              ),
                            ),
                          ),
                          4.dpv,
                        ],
                      ),
                    ),
                  ),
                  8.dpv,
                  ConditionalUI<List<Question>>(
                    skeleton: const MyLoader(),
                    state: bloc.apiState,
                    onSuccess: (data) {
                      return Column(
                        children: bloc.questionsWithCategory
                            .map((questionObject) => Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      questionObject.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    4.dpv,
                                    ListView.separated(
                                      padding: 8.dpeh,
                                      itemBuilder: (context, index) {
                                        return AssessmentItemUi(
                                          item:
                                              questionObject.questions?[index],
                                          questionModel: bloc.questions
                                              .firstWhere((element) =>
                                                  element
                                                      .assessmentQuestionId ==
                                                  questionObject
                                                      .questions?[index]
                                                      .questionId
                                                      ?.toString()),
                                          onOptionSelected:
                                              bloc.onOptionSelected,
                                          onChangeDescription:
                                              bloc.onChangeDesc,
                                        );
                                      },
                                      itemCount:
                                          questionObject.questions?.length ?? 0,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      separatorBuilder: (context, index) =>
                                          20.dpv,
                                    ),
                                    4.dpv,
                                    const Divider(),
                                    4.dpv,
                                  ],
                                ))
                            .toList(),
                      );
                    },
                  ),
                  16.dpv,
                  ElevatedButton(
                    onPressed: bloc.submitQuestions,
                    child: bloc.sendDataState.isLoading
                        ? const MyLoader()
                        : const Text('ارسال پاسخ'),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class AssessmentItemUi extends StatelessWidget {
  const AssessmentItemUi({
    Key? key,
    required this.item,
    required this.questionModel,
    required this.onOptionSelected,
    required this.onChangeDescription,
  }) : super(key: key);
  final Question? item;
  final QuestionModel questionModel;
  final Function(String?, Option?) onOptionSelected;
  final Function(String?, String) onChangeDescription;

  @override
  Widget build(BuildContext context) {
    var index = item?.options?.indexWhere((element) =>
        element.optionId?.toString() ==
        questionModel.assessmentQuestionOptionId);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: 16.dpe,
          margin: 4.dpe,
          decoration: BoxDecoration(
            borderRadius: 8.bRadius,
            color: Colors.grey.shade50,
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Text(item?.questionTitle ?? ''),
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
            itemCount: item?.options?.length,
            itemBuilder: (context, index) => SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value:
                        item?.options?.elementAt(index).optionId?.toString() ==
                            questionModel.assessmentQuestionOptionId,
                    onChanged: (value) {
                      print(value);
                      onOptionSelected.call(
                          item?.questionId?.toString(),
                          value == true
                              ? item?.options?.elementAt(index)
                              : null);
                    },
                  ),
                  Expanded(
                    child: Text(
                      item?.options?[index].optionTitle ?? '',
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
          height: 150,
          child: TextFormFieldHelper(
            hint: getDescriptionText(index ?? 0),
            keyboardType: TextInputType.text,
            label: getDescriptionText(index ?? 0),
            onChangeValue: (value) {
              onChangeDescription.call(item?.questionId?.toString(), value);
            },
            expand: true,
            textAlign: TextAlign.start,
          ),
        )
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
}
