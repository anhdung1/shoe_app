import 'dart:async';

import 'package:bloc_app/bloc/pagehome_bloc/pagehome_event.dart';
import 'package:bloc_app/bloc/pagehome_bloc/pagehome_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PagehomeBloc extends Bloc<PagehomeEvent, PagehomeState> {
  PagehomeBloc() : super(PageInitialState(tabIndex: 0)) {
    on<PageSelectEvent>(select);
  }

  FutureOr<void> select(PageSelectEvent event, Emitter<PagehomeState> emit) {
    emit(PageInitialState(tabIndex: event.tabIndex));
  }
}
