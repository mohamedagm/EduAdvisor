import 'package:edu_advisor/features/services/data/repo/recommendation_repo.dart';
import 'package:edu_advisor/features/services/manager/recommendation_cubit/recommendation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendationCubit extends Cubit<RecommendationState> {
  RecommendationCubit({required RecommendationRepo repo})
    : _repo = repo,
      super(const RecommendationInitial());

  final RecommendationRepo _repo;

  Future<void> getRecommendations() async {
    emit(const RecommendationLoading());

    final result = await _repo.getRecommendations();

    if (isClosed) return;

    result.fold(
      (failure) => emit(RecommendationFailure(failure)),
      (data) => emit(RecommendationLoaded(data)),
    );
  }
}
