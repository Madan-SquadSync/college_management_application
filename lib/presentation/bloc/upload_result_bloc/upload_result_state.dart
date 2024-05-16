abstract class UploadResultState {
  int count;
  UploadResultState({required this.count});
}

class UploadResultInitialState extends UploadResultState {
  UploadResultInitialState({required super.count});
}

class UploadResultLoadingState extends UploadResultState {
  UploadResultLoadingState({required super.count});
}

class UploadResultLoadedState extends UploadResultState {
  UploadResultLoadedState({required super.count});
}

class UploadResultUploadTheCountState extends UploadResultState {
  final int value;
  UploadResultUploadTheCountState({required this.value}) : super(count: value);
}
