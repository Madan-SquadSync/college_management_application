abstract class TakeAttendanceState {}

class TakeAttendanceInitialState extends TakeAttendanceState {}

class TakeAttendanceUpdateUIState extends TakeAttendanceState {}

class TakeAttendanceRetrieveingStudentLoadingState
    extends TakeAttendanceState {}

class TakeAttendanceRetrieveingStudentLoadedState extends TakeAttendanceState {}

class TakeAttendanceUploadAttendanceLoadingState extends TakeAttendanceState {}

class TakeAttendanceUploadAttendanceLoadedState extends TakeAttendanceState {}
