import 'dart:async';

import 'package:bloc_app/bloc/timer_bloc/timer_state.dart';
import 'package:bloc_app/bloc/timer_bloc/timer_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountdownBloc extends Bloc<CountdownEvent, CountdownState> {
  Timer? _timer;

  CountdownBloc() : super(const CountdownInitial(60)) {
    on<StartCountdown>(_onStartCountdown);
    on<Tick>(_onTick);
  }

  void _onStartCountdown(StartCountdown event, Emitter<CountdownState> emit) {
    emit(CountdownRunInProgress(event.duration));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final duration = event.duration - timer.tick;

      if (duration > 0) {
        add(Tick(duration));
      } else {
        add(Tick(0));
        _timer?.cancel();
      }
    });
  }

  void _onTick(Tick event, Emitter<CountdownState> emit) {
    emit(event.duration > 0
        ? CountdownRunInProgress(event.duration)
        : const CountdownRunComplete());
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
