abstract class AddStudentsState {
  String filename;
  AddStudentsState({required this.filename});
}

class AddStudentsInitialState extends AddStudentsState {
  AddStudentsInitialState({required super.filename});
}

class AddStudentsUpdateState extends AddStudentsState {
  final String value;
  AddStudentsUpdateState(this.value) :super(filename: value);
}

class AddStudentsLoadingState extends AddStudentsState {
  AddStudentsLoadingState({required super.filename});
}

class AddStudentsLoadedState extends AddStudentsState {
  AddStudentsLoadedState({required super.filename});
}
