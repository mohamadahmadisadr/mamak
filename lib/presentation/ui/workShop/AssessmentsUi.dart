import 'package:flutter/material.dart';
import 'package:mamak/config/uiCommon/MyTheme.dart';
import 'package:mamak/data/serializer/assessment/QuestionsResponse.dart';
import 'package:mamak/presentation/ui/assessment/AssessmentItemUi.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MamakScaffold.dart';
import 'package:mamak/presentation/ui/main/MamakTitle.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/viewModel/assessments/AssessmentsViewModel.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';

import '../main/MyLoader.dart';

class AssessmentsUi extends StatefulWidget {
  const AssessmentsUi({Key? key}) : super(key: key);

  @override
  State<AssessmentsUi> createState() => _AssessmentsUiState();
}

class _AssessmentsUiState extends State<AssessmentsUi> {
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
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
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
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: bloc.questionsWithCategory.length,
                        itemBuilder: (context, qIndex) {
                          var questionObject =
                              bloc.questionsWithCategory.elementAt(qIndex);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                questionObject.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              4.dpv,
                              ListView.separated(
                                padding: 8.dpeh,
                                itemBuilder: (context, index) {
                                  return AssessmentItemUi(
                                      index: qIndex + 1,
                                      item: questionObject.questions?[index]);
                                },
                                itemCount:
                                    questionObject.questions?.length ?? 0,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) => 20.dpv,
                              ),
                              4.dpv,
                              const Divider(),
                              4.dpv,
                            ],
                          );
                        },
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

// class AssessmentItemUi extends StatefulWidget {
//   const AssessmentItemUi({
//     Key? key,
//     required this.item,
//     required this.questionModel,
//     required this.onOptionSelected,
//     required this.onChangeDescription,
//   }) : super(key: key);
//   final Question? item;
//   final QuestionModel questionModel;
//   final Function(String?, Option?) onOptionSelected;
//   final Function(String?, String) onChangeDescription;
//
//   // late Uint8List content;
//
//   @override
//   State<AssessmentItemUi> createState() => _AssessmentItemUiState();
// }
//
// class _AssessmentItemUiState extends State<AssessmentItemUi> {
//   int? index = 0;
//
//   @override
//   void initState() {
//     index = widget.item?.options?.indexWhere((element) =>
//         element.optionId?.toString() ==
//         widget.questionModel.assessmentQuestionOptionId);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         4.dpv,
//         if (widget.item?.questionPicture != null &&
//             widget.item?.questionPicture?.content != null)
//           FutureBuilder(
//             future:
//                 getBase64FromContent(widget.item!.questionPicture!.content!),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 return ClipRRect(
//                   borderRadius: 16.bRadius,
//                   child: SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       height: 150.0,
//                       child: Image.memory(
//                         base64Decode(widget.item!.questionPicture!.content!),
//                         fit: BoxFit.contain,
//                       )),
//                 );
//               }
//               return const SizedBox(
//                 height: 150,
//                 child: Center(child: MyLoader()),
//               );
//             },
//           ),
//         8.dpv,
//         Container(
//           padding: 16.dpe,
//           margin: 4.dpe,
//           decoration: BoxDecoration(
//             borderRadius: 8.bRadius,
//             color: Colors.grey.shade50,
//             border: Border.all(color: Colors.grey.shade100),
//           ),
//           child: Text(widget.item?.questionTitle ?? ''),
//         ),
//         Container(
//           padding: 16.dpe,
//           margin: 4.dpe,
//           decoration: BoxDecoration(
//             borderRadius: 8.bRadius,
//             color: Colors.blue.shade50,
//             border: Border.all(color: Colors.blue.shade100),
//           ),
//           child: ListView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: widget.item?.options?.length,
//             itemBuilder: (context, index) => SizedBox(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Checkbox(
//                     value: widget.item?.options
//                             ?.elementAt(index)
//                             .optionId
//                             ?.toString() ==
//                         widget.questionModel.assessmentQuestionOptionId,
//                     onChanged: (value) {
//                       print(value);
//                       widget.onOptionSelected.call(
//                           widget.item?.questionId?.toString(),
//                           value == true
//                               ? widget.item?.options?.elementAt(index)
//                               : null);
//                     },
//                   ),
//                   Expanded(
//                     child: Text(
//                       widget.item?.options?[index].optionTitle ?? '',
//                       style: context.textTheme.titleSmall
//                           ?.copyWith(fontWeight: FontWeight.bold, fontSize: 12),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//         8.dpv,
//         SizedBox(
//           height: 100,
//           child: TextFormFieldHelper(
//             hint: getDescriptionText(index ?? 0),
//             keyboardType: TextInputType.text,
//             label: getDescriptionText(index ?? 0),
//             onChangeValue: (value) {
//               widget.onChangeDescription
//                   .call(widget.item?.questionId?.toString(), value);
//             },
//             expand: true,
//             textAlign: TextAlign.start,
//           ),
//         ),
//       ],
//     );
//   }
//
//   String getDescriptionText(int index) {
//     if (index == -1) return 'پاسخ';
//     if (index == 0 || index == 1) {
//       return 'هدفگذاری';
//     }
//     return 'راهکار';
//   }
//
//   Future<Uint8List> getBase64FromContent(String content) async =>
//       base64Decode(widget.item!.questionPicture!.content!);
// }
