abstract class AttendanceStatusState {}

class AttendanceStatusInitialState extends AttendanceStatusState {}

class AttendanceStatusUpdateUIState extends AttendanceStatusState {}

class AttendanceStatusRetrieveingStudentLoadingState
    extends AttendanceStatusState {}

class AttendanceStatusRetrieveingStudentLoadedState extends AttendanceStatusState {}
