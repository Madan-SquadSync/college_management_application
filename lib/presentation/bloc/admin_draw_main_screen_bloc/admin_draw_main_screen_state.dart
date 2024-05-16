abstract class AdminDrawMainScreenState {
  int currentScreen;
  AdminDrawMainScreenState({required this.currentScreen});
}

class AdminDrawMainScreenInitializationState extends AdminDrawMainScreenState {
  AdminDrawMainScreenInitializationState({required super.currentScreen});
}

class AdminDrawMainScreenUpdateState extends AdminDrawMainScreenState {
  int changeCurrentScreen;
  AdminDrawMainScreenUpdateState({required this.changeCurrentScreen})
      : super(currentScreen: changeCurrentScreen);
}
