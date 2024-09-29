import 'package:equatable/equatable.dart';

abstract class AdminEditStatusState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdminEditStatusSuccessState extends AdminEditStatusState {
  final String status;

  AdminEditStatusSuccessState({required this.status});
  @override
  List<Object?> get props => [status];
}

class AdminEditStatusInitalState extends AdminEditStatusState {}
