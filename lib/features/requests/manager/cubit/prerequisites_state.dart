

import 'package:edu_advisor/features/requests/models/prerequisite_model.dart';

abstract class PrerequisitesState {}

class PrerequisitesInitialState extends PrerequisitesState {}

class PrerequisitesLoadingState extends PrerequisitesState {}

class PrerequisitesSuccessState extends PrerequisitesState {
  final List<PrerequisiteCourseModel> prerequisites;

  PrerequisitesSuccessState(this.prerequisites);
}

class PrerequisitesErrorState extends PrerequisitesState {
  final String message;

  PrerequisitesErrorState(this.message);
}