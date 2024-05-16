abstract class TimeTablesState {
  int value;
  TimeTablesState({required this.value});
}

class TimeTablesInsitialState extends TimeTablesState {
  TimeTablesInsitialState({required super.value});
}

class TimeTablesUpdateValueState extends TimeTablesState {
  int value;
  TimeTablesUpdateValueState({required this.value}) : super(value: value);
}
