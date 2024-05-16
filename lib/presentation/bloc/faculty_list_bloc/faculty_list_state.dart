abstract class FacultyListState {}

class FacultyListInitialState extends FacultyListState {}

class FacultyListLoadingState extends FacultyListState {}

class FacultyListLoadedState extends FacultyListState {
  FacultyListLoadedState();
}

class FacultyListErrorState extends FacultyListState {
  final String errorMessage;

  FacultyListErrorState(this.errorMessage);
}
