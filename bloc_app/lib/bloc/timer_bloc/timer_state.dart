import 'package:equatable/equatable.dart';

abstract class CountdownState extends Equatable {
  final int duration;

  const CountdownState(this.duration);

  @override
  List<Object> get props => [duration];
}

class CountdownInitial extends CountdownState {
  const CountdownInitial(super.duration);
}

class CountdownRunInProgress extends CountdownState {
  const CountdownRunInProgress(super.duration);
}

class CountdownRunComplete extends CountdownState {
  const CountdownRunComplete() : super(0);
}
