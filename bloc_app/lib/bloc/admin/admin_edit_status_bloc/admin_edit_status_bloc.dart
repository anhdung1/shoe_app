import 'dart:async';

import 'package:bloc_app/bloc/admin/admin_edit_status_bloc/admin_edit_status_event.dart';
import 'package:bloc_app/bloc/admin/admin_edit_status_bloc/admin_edit_status_state.dart';
import 'package:bloc_app/response/orders_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminEditStatusBloc
    extends Bloc<AdminEditStatusEvent, AdminEditStatusState> {
  AdminEditStatusBloc(super.initialState) {
    on<AdminOnEditStatusEvent>(_editStatus);
  }

  FutureOr<void> _editStatus(
      AdminOnEditStatusEvent event, Emitter<AdminEditStatusState> emit) async {
    var isSuccess = await OrdersResponse.editStatus(event.code, event.status);
    if (isSuccess == "Success") {
      emit(AdminEditStatusSuccessState(status: event.status));
    }
  }
}
