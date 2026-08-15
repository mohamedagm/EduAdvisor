import 'package:edu_advisor/features/auth/data/models/faculties_query_params.dart';
import 'package:edu_advisor/features/auth/data/repo/faculties_repo.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/faculties_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FacultiesCubit extends Cubit<FacultiesState> {
  final FacultiesRepo _facultiesRepo;

  FacultiesCubit({required FacultiesRepo facultiesRepo})
    : _facultiesRepo = facultiesRepo,
      super(const FacultiesInitial());

  Future<void> fetchFaculties() async {
    if (state is FacultiesLoading) return;

    emit(const FacultiesLoading());

    final result = await _facultiesRepo.getFaculties(
      const FacultiesQueryParams(),
    );

    result.fold(
      (failure) => emit(FacultiesFailure(failure)),
      (paginated) => emit(FacultiesSuccess(paginated.items)),
    );
  }
}
