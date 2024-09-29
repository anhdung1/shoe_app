import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_app/bloc/auth_bloc/auth_event.dart';
import 'package:bloc_app/bloc/auth_bloc/auth_state.dart';
import 'package:bloc_app/ip_v4.dart';
import 'package:bloc_app/local_variable.dart';
import 'package:bloc_app/models/user_data_model.dart';
import 'package:bloc_app/network/check_connection.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthLoginInitialState()) {
    on<AuthLoginCallbackEvent>(_callbacklogin);
    on<AuthLoginEvent>(_login);
    on<AuthRegisterEvent>(_register);
    on<AuthRegisterCallbackEvent>(_callbackregister);
    on<AuthSendRegisterEvent>(_authSendRegisterEvent);
    on<AuthRegisterPasswordErrorEvent>(_authRegisterPasswordErrorEvent);
  }

  _login(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoginLoadingState());
    try {
      if (await checkInternetConnection() == false) {
        return emit(AuthLoginErrorState(error: "No Internet"));
      }

      var response = await http.Client().post(
        Uri.parse('http://$ip:8080/api/auth/login'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'username': event.userName,
          'password': event.password
        }),
      );

      if (response.statusCode == 200) {
        UserDataModel user = UserDataModel.fromMap(
            jsonDecode(utf8.decode(response.bodyBytes))
                as Map<String, dynamic>);

        for (int i = 0; i < user.roles.length; i++) {
          if (user.roles[i].name == 'ADMIN') {
            return emit(AuthAdminLoginSuccessState(user: user));
          }
        }
        emit(AuthLoginSuccessState(user: user));
        userId = user.id;
        userName = user.username;
      } else {
        emit(AuthLoginErrorState(error: response.body.toString()));
      }
    } catch (e) {
      debugPrint('Caught error: $e');
    }
  }

  FutureOr<void> _register(
      AuthRegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthRegisterInitialState());
  }

  FutureOr<void> _callbacklogin(
      AuthLoginCallbackEvent event, Emitter<AuthState> emit) {
    emit(AuthLoginInitialState());
  }

  FutureOr<void> _callbackregister(
      AuthRegisterCallbackEvent event, Emitter<AuthState> emit) {
    emit(AuthRegisterInitialState());
  }

  FutureOr<void> _authSendRegisterEvent(
      AuthSendRegisterEvent event, Emitter<AuthState> emit) async {
    if (event.password != event.passwordAgain || event.password.length <= 2) {
      emit(
          AuthRegisterErrorPasswordAgainState(error: "Passwords do not match"));
    } else if (event.username.length < 6 || event.username.length > 16) {
      emit(AuthRegisterErrorUserNameState(
          error: "Account must be greater than 6 and less than 16 characters"));
    } else {
      try {
        Map<String, dynamic> newUser = {
          "username": event.username,
          "password": event.password,
          "firstName": event.name
        };
        var response = await http.Client().post(
            Uri.parse(
              "http://$ip:8080/api/auth/register",
            ),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(newUser));
        if (response.statusCode == 201) {
          emit(AuthRegisterSuccessState());
        } else {
          emit(AuthRegisterErrorState(error: response.body.toString()));
        }
      } catch (e) {
        debugPrint('Caught error: $e');
      }
    }
  }

  FutureOr<void> _authRegisterPasswordErrorEvent(
      AuthRegisterPasswordErrorEvent event, Emitter<AuthState> emit) {
    emit(AuthRegisterPasswordErrorState());
  }
}
