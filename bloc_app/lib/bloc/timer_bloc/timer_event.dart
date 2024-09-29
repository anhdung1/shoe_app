import 'package:equatable/equatable.dart';

abstract class CountdownEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartCountdown extends CountdownEvent {
  final int duration;

  StartCountdown(this.duration);

  @override
  List<Object> get props => [duration];
}

class Tick extends CountdownEvent {
  final int duration;

  Tick(this.duration);

  @override
  List<Object> get props => [duration];
}
