import 'package:equatable/equatable.dart';

abstract class AddFacultyState extends Equatable {
  const AddFacultyState();

  @override
  List<Object> get props => [];
}

class AddFacultyInitial extends AddFacultyState {}

class AddFacultyLoading extends AddFacultyState {}

class AddFacultyAddedSuccessfully extends AddFacultyState {}

class AddFacultyError extends AddFacultyState {
  final String errorMessage;

  const AddFacultyError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
