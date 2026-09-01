import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/services/data/models/recommendation_data_model.dart';

abstract class RecommendationState {
  const RecommendationState();
}

class RecommendationInitial extends RecommendationState {
  const RecommendationInitial();
}

class RecommendationLoading extends RecommendationState {
  const RecommendationLoading();
}

class RecommendationLoaded extends RecommendationState {
  const RecommendationLoaded(this.data);

  final RecommendationDataModel data;
}

class RecommendationFailure extends RecommendationState {
  const RecommendationFailure(this.failure);

  final Failure failure;
}
