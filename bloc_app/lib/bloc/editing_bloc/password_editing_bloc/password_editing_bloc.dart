import 'dart:async';
import 'dart:convert';

import 'package:bloc_app/bloc/editing_bloc/password_editing_bloc/password_editing_event.dart';
import 'package:bloc_app/bloc/editing_bloc/password_editing_bloc/password_editing_state.dart';
import 'package:bloc_app/ip_v4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class PasswordEditingBloc
    extends Bloc<PasswordEditingEvent, PasswordEditingState> {
  PasswordEditingBloc() : super(PasswordEditingInitialState()) {
    on<PasswordEditing>(_passwordEditingEvent);
  }

  FutureOr<void> _passwordEditingEvent(
      PasswordEditing event, Emitter<PasswordEditingState> emit) async {
    emit(PasswordEditingLoadingState());
    var client = http.Client();
    try {
      if (event.newPassword == event.againNewPassword &&
          event.newPassword.isNotEmpty &&
          event.currentPassword.isNotEmpty) {
        var response = await client.put(
            Uri.parse("http://$ip:8080/users/edit/${event.id}/password"),
            headers: <String, String>{'Content-Type': 'application/json'},
            body: jsonEncode({
              'password': event.currentPassword,
              'newPassword': event.newPassword
            }));
        if (response.statusCode == 200) {
          emit(PasswordEditingSuccessState());
        } else {
          emit(PasswordEditingErrorState(
              error: "Current password is incorrect"));
        }
      } else if (event.newPassword.isEmpty || event.currentPassword.isEmpty) {
        emit(PasswordEditingErrorState(
            error: "Please do not leave the password blank"));
      } else {
        emit(PasswordEditingErrorState(error: "Password do not match"));
      }
    } catch (e) {
      debugPrint('Caught error: $e');
    }
  }
}
