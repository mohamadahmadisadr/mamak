class WorkBookDetailUiModel {
  final List<String> header;
  final List<WorkBookDetailReviews> reviews;

  const WorkBookDetailUiModel({
    required this.header,
    required this.reviews,
  });
}

class WorkBookDetailReviews {
  final String question, comment;

  const WorkBookDetailReviews({
    required this.question,
    required this.comment
  });
}