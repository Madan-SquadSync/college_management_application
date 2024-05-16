import 'package:equatable/equatable.dart';

abstract class EditFacultyState extends Equatable {
  const EditFacultyState();

  @override
  List<Object> get props => [];
}

class EditFacultyInitial extends EditFacultyState {}

class EditFacultyLoading extends EditFacultyState {}

class EditFacultyAddedSuccessfully extends EditFacultyState {}

class EditFacultyError extends EditFacultyState {
  final String errorMessage;

  const EditFacultyError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
