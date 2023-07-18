import 'package:core/Notification/MyNotification.dart';
import 'package:mamak/data/body/assessment/ParticipateAssessmentBody.dart';
import 'package:mamak/data/serializer/assessment/QuestionsResponse.dart';
import 'package:mamak/presentation/uiModel/QuestionModel.dart';
import 'package:mamak/presentation/uiModel/assessmeny/AssessmentParamsModel.dart';
import 'package:mamak/presentation/uiModel/workBook/WorkBookParamsModel.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/assessment/GetAssessmentQuestionsUseCase.dart';
import 'package:mamak/useCase/assessment/ParticipateAssessmentUseCase.dart';

class AssessmentsViewModel extends BaseViewModel {
  final ParticipateAssessmentBody body = ParticipateAssessmentBody();
  List<QuestionModel> questions = List.empty(growable: true);
  List<QuestionsObject> questionsWithCategory = List.empty(growable: true);
  AssessmentParamsModel? assessmentParamsModel;
  final MyNotification _notification = GetIt.I.get();

  AppState apiState = AppState.idle;
  AppState sendDataState = AppState.idle;
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();

  AssessmentsViewModel(super.initialState) {
    getExtra();
  }

  void getQuestions(String id) {
    GetAssessmentQuestionsUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.isSuccess && appState.getData is List<Questions>) {
        List<Questions> data = appState.getData;
        List<Question> allQuestions = List.empty(growable: true);
        data.map((e) => allQuestions.addAll(e.questions ?? [])).toList();
        data
            .map((e) => questionsWithCategory.add(QuestionsObject(
                title: e.categoryTitle ?? '', questions: e.questions)))
            .toList();
        for (var q in allQuestions) {
          questions.add(QuestionModel(
              assessmentQuestionId: q.questionId?.toString() ?? ''));
        }
        apiState = AppState.success(allQuestions);
      }
      if (!apiState.isSuccess) {
        apiState = appState;
      }

      refresh();
    }), data: id);
  }

  void refresh() {
    updateScreen(time: DateTime.now().microsecondsSinceEpoch.toDouble());
  }

  List<QuestionModel> getModel(List<Question> data) {
    return data
        .map((e) =>
            QuestionModel(assessmentQuestionId: e.questionId?.toString() ?? ''))
        .toList();
  }

  void getExtra() {
    var id = _navigationServiceImpl.getArgs();
    if (id != null && id is AssessmentParamsModel) {
      assessmentParamsModel = id;
      body.userChildWorkshopId = id.id;
      getQuestions(id.id);
    }
  }

  onOptionSelected(String? qId, Option? option) {
    if (qId != null && option != null) {
      var index = questions
          .indexWhere((element) => element.assessmentQuestionId == qId);
      if (index != -1) {
        questions[index].assessmentQuestionOptionId =
            option.optionId.toString();
      }
    }
  }

  onChangeDesc(String? qId, String text) {
    if (qId != null) {
      var index = questions
          .indexWhere((element) => element.assessmentQuestionId == qId);
      if (index != -1) {
        questions[index].description = text;
      }
    }
  }

  bool get isValid {
    var index = questions.indexWhere((element) => element.isValid == false);
    if (index == -1) return true;
    messageService.showSnackBar('سوال شماره ${index + 1} را پاسخ دهید.');
    return false;
  }

  void submitQuestions() {
    if (isValid) {
      body.data = questions.map((element) => element.createBody()).toList();
      ParticipateAssessmentUseCase().invoke(
        MyFlow(flow: (appState) {
          if (appState.isFailed) {
            messageService.showSnackBar(appState.getErrorModel?.message ?? '');
          }
          if (appState.isSuccess) {
            _notification.publish('MyWorkShopsViewModel', true);
            messageService.showSnackBar('ارزیابی فرزند با موفقیت انجام شد');
            WorkBookParamsModel model = WorkBookParamsModel(
              userChildId: assessmentParamsModel?.childId ?? '',
              workShopId: assessmentParamsModel?.workShopId ?? '',
            );
            Future.delayed(const Duration(seconds: 2)).then((value){
              _navigationServiceImpl.replaceTo(
                AppRoute.workBookDetail,
                model,
              );
            });

          }
          sendDataState = appState;
          refresh();
        }),
        data: body,
      );
    }
  }

  List<String> get getAssessmentModelAsList =>
      [assessmentParamsModel?.name ?? '', assessmentParamsModel?.course ?? ''];
}
