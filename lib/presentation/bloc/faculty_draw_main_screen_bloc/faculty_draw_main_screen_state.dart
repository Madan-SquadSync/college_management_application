abstract class FacultyDrawMainScreenState {
  int currentScreen;
  FacultyDrawMainScreenState({required this.currentScreen});
}

class FacultyDrawMainScreenInitializationState extends FacultyDrawMainScreenState {
  FacultyDrawMainScreenInitializationState({required super.currentScreen});
}

class FacultyDrawMainScreenUpdateState extends FacultyDrawMainScreenState {
  int changeCurrentScreen;
  FacultyDrawMainScreenUpdateState({required this.changeCurrentScreen})
      : super(currentScreen: changeCurrentScreen);
}
