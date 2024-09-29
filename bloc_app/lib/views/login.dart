import 'package:bloc_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:bloc_app/bloc/auth_bloc/auth_event.dart';
import 'package:bloc_app/bloc/auth_bloc/auth_state.dart';
import 'package:bloc_app/views/admin/admin_home.dart';

import 'package:bloc_app/views/user/myhome.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordRegister = TextEditingController();
  final TextEditingController _nameRegister = TextEditingController();
  final TextEditingController _passwordAgainRegister = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  var borderColor = Colors.black26;
  login(BuildContext context1) {
    context.read<AuthBloc>().add(
        AuthLoginEvent(userName: _userName.text, password: _password.text));
  }

  void _register() {
    context.read<AuthBloc>().add(AuthRegisterEvent());
  }

  void backLogin() {
    context.read<AuthBloc>().add(AuthLoginCallbackEvent());
  }

  void backRegister() {
    context.read<AuthBloc>().add(AuthRegisterEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoginInitialState) {
          return loginState(context, "");
        }
        if (state is AuthLoginErrorState) {
          return loginState(context, state.error);
        }

        if (state is AuthLoginLoadingState ||
            state is AuthRegisterLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is AuthRegisterInitialState) {
          return registerState("", "");
        }
        if (state is AuthRegisterSuccessState) {
          return loginErrorState(() {
            backLogin();
          }, "Register Success");
        }
        if (state is AuthRegisterErrorPasswordAgainState) {
          return registerState(state.error, "");
        }
        if (state is AuthRegisterErrorUserNameState) {
          return registerState("", state.error);
        }
        if (state is AuthRegisterErrorState) {
          return loginErrorState(() {
            backRegister();
          }, state.error);
        }
        return const Center();
      },
      listener: (BuildContext context, AuthState state) {
        if (state is AuthLoginSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => MyHome(
                      userDataModel: state.user,
                    )),
            (Route<dynamic> route) => false,
          );
        }
        if (state is AuthAdminLoginSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => AdminHome(
                      user: state.user,
                    )),
            (Route<dynamic> route) => false,
          );
        }
      },
    ));
  }

  loginErrorState(onTap, nameError) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black12,
      child: Center(
        child: Container(
          width: 300,
          height: 120,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 3),
                  color: Colors.black26,
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            borderRadius: BorderRadius.circular(6),
            // border: Border.all(width: 0.3),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  nameError,
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: InkWell(
                      onTap: onTap,
                      child: Container(
                          alignment: AlignmentDirectional.center,
                          width: 50,
                          height: 25,
                          decoration: BoxDecoration(
                              color: Colors.blue[400],
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            "OK",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  loginState(BuildContext context1, error) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10, top: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Image.asset(
                "assets/images/background.png",
                width: 72,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: Text(
                "Welcome to Lafyuu",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Text(
                "Sign in to continue",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black38),
              ),
            ),
            textField(_userName, Icons.email_outlined, false, "User Name", ""),
            textField(_password, Icons.lock_outlined, true, "Password", error),
            loginButon(() {
              login(context1);
            }, "Sign In"),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: borderColor,
                      margin: const EdgeInsets.only(right: 15),
                    ),
                  ),
                  const Text(
                    "OR",
                    style: TextStyle(
                        fontWeight: FontWeight.w800, color: Colors.black38),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: borderColor,
                      margin: const EdgeInsets.only(left: 15),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: loginWith(() {}, "Google", Icons.email_outlined),
            ),
            loginWith(() {}, "Facebook", Icons.facebook_rounded),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: InkWell(
                  onTap: () {},
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue[400]),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have to account?",
                  style: TextStyle(color: borderColor, fontSize: 14),
                ),
                InkWell(
                    onTap: () {
                      _register();
                    },
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Text(
                      " Register",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue[400]),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  registerState(errorAgainPassword, errorUserName) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 110),
              child: Image.asset(
                "assets/images/background.png",
                width: 72,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: Text(
                "Let's Get Started",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Text(
                "Create an new account",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black45),
              ),
            ),
            textField(_userNameController, Icons.email_outlined, false,
                "User Name", errorUserName),
            textField(
                _passwordRegister, Icons.lock_outlined, true, "Password", ""),
            textField(_passwordAgainRegister, Icons.lock_outlined, true,
                "Password Again", errorAgainPassword),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 25),
              child: loginButon(() {
                context.read<AuthBloc>().add(AuthSendRegisterEvent(
                    name: _nameRegister.text,
                    username: _userNameController.text,
                    password: _passwordRegister.text,
                    passwordAgain: _passwordAgainRegister.text));
              }, "Sign Up"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Have a account?",
                  style: TextStyle(color: borderColor, fontSize: 14),
                ),
                InkWell(
                    onTap: () {
                      backLogin();
                    },
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Text(
                      " Sign In",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue[400]),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  loginWith(onTap, nameButton, icon) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        alignment: AlignmentDirectional.center,
        height: 57,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(width: 0.3, color: borderColor)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                icon,
                color: Colors.blue[300],
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "Login with $nameButton",
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black45,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  loginButon(onTap, name) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        alignment: AlignmentDirectional.center,
        height: 57,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7), color: Colors.blue[400]),
        child: Text(
          name,
          style: const TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  textField(controller, prefixIcon, hide, hinText, String error) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter";
              }
              return null;
            },
            // initialValue: "emily.johnson@x.dummyjson.com",
            obscureText: hide,

            controller: controller,
            decoration: InputDecoration(
                hintText: hinText,
                hintStyle: const TextStyle(
                    color: Colors.black26,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                contentPadding: const EdgeInsets.only(top: 12, left: 10),
                prefixIcon: Icon(
                  prefixIcon,
                  color: Colors.black38,
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(7))),
          ),
          if (error.isNotEmpty)
            Text(
              error,
              style: const TextStyle(color: Colors.red),
            )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _password.dispose();
    _userName.dispose();
    _userNameController.dispose();
    _nameRegister.dispose();
    _passwordAgainRegister.dispose();
    _passwordRegister.dispose();
  }
}
