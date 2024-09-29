import 'package:bloc_app/bloc/editing_bloc/password_editing_bloc/password_editing_bloc.dart';
import 'package:bloc_app/bloc/editing_bloc/password_editing_bloc/password_editing_event.dart';
import 'package:bloc_app/bloc/editing_bloc/password_editing_bloc/password_editing_state.dart';
import 'package:bloc_app/main.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordEditingPage extends StatefulWidget {
  const PasswordEditingPage({super.key, required this.id});
  final int id;

  @override
  State<PasswordEditingPage> createState() => _PasswordEditingPageState();
}

class _PasswordEditingPageState extends State<PasswordEditingPage> {
  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _againNewPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => PasswordEditingBloc(),
        child: BlocConsumer<PasswordEditingBloc, PasswordEditingState>(
          builder: (context, state) {
            if (state is PasswordEditingInitialState) {
              return initPage("", false, () {
                context.read<PasswordEditingBloc>().add(PasswordEditing(
                    currentPassword: _currentPassword.text,
                    newPassword: _newPassword.text,
                    againNewPassword: _againNewPassword.text,
                    id: widget.id));
              });
            }
            if (state is PasswordEditingErrorState) {
              return initPage(state.error, true, () {
                context.read<PasswordEditingBloc>().add(PasswordEditing(
                    currentPassword: _currentPassword.text,
                    newPassword: _newPassword.text,
                    againNewPassword: _againNewPassword.text,
                    id: widget.id));
              });
            }
            if (state is PasswordEditingLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const SizedBox();
          },
          listener: (BuildContext context, state) {
            if (state is PasswordEditingSuccessState) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
                (Route<dynamic> route) => false,
              );
            }
          },
        ),
      ),
    );
  }

  initPage(error, hide, onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          nameTitle("Current Password"),
          textField(_currentPassword),
          nameTitle("New Password"),
          textField(_newPassword),
          nameTitle("Re-enter password"),
          textField(_againNewPassword),
          if (hide)
            Text(
              error,
              style: const TextStyle(color: Colors.red),
            ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: saveButton(onTap),
          )
        ],
      ),
    );
  }

  saveButton(onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
          alignment: AlignmentDirectional.center,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7), color: Colors.blue[400]),
          width: MediaQuery.of(context).size.width,
          child: const Text(
            "Save",
            style: TextStyle(fontSize: 16, color: Colors.white),
          )),
    );
  }

  nameTitle(name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 0),
      child: Text(
        name,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }

  textField(controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        height: 48,
        child: TextFormField(
          obscureText: true,
          controller: controller,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(bottom: 55, left: 10),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
              prefixIcon: const Icon(Icons.lock),
              hintText: "***********",
              hintStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black38)),
        ),
      ),
    );
  }
}
