import 'package:bloc/bloc.dart';
import 'package:bloc_app/bloc/count_bloc/count_event.dart';

class CountBloc extends Bloc<CountEvent, int> {
  CountBloc(super.initialState) {
    on<CountIncreateEvent>(
      (event, emit) {
        emit(state + 1);
      },
    );
    on<CountDecreateEvent>(
      (event, emit) {
        if (state > 1) {
          emit(state - 1);
        }
      },
    );
  }
}
