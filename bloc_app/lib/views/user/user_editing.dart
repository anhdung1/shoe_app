import 'dart:ui';

import 'package:bloc_app/bloc/editing_bloc/user_bloc/user_bloc.dart';
import 'package:bloc_app/bloc/editing_bloc/user_bloc/user_event.dart';
import 'package:bloc_app/bloc/editing_bloc/user_bloc/user_state.dart';
import 'package:bloc_app/models/user_data_model.dart';
import 'package:bloc_app/views/user/myhome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserEditing extends StatefulWidget {
  final UserDataModel user;
  const UserEditing({super.key, required this.user});
  @override
  State<UserEditing> createState() => _UserEditingState();
}

class _UserEditingState extends State<UserEditing> {
  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _maidenNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String? _selectedValue;
  @override
  void initState() {
    _selectedValue = widget.user.gender;
    super.initState();
    _firstNameController.text = widget.user.firstName!;
    _maidenNameController.text = widget.user.maidenName;
    _emailController.text = widget.user.email;
    _phoneController.text = widget.user.phone;
    _ageController.text = widget.user.age.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(UserEditingInitalState(user: widget.user)),
      child: BlocConsumer<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserEditingInitalState) {
            return initScreen(
                context,
                widget.user.firstName,
                widget.user.maidenName,
                widget.user.email,
                widget.user.age,
                widget.user.phone);
          }
          if (state is UserEditingLoadingState) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return const Scaffold();
        },
        listener: (BuildContext context, UserState state) {
          if (state is UserEditingSuccessState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHome(userDataModel: state.user),
                ));
          }
        },
      ),
    );
  }

  initScreen(
    BuildContext context1,
    firstName,
    maidenName,
    email,
    age,
    phone,
  ) {
    return Scaffold(
      appBar: AppBar(),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch}),
        child: ListView(
          padding: const EdgeInsets.only(left: 10, right: 10),
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: nameTitle("First Name"),
            ),
            textField(_firstNameController, firstName, null, null, false),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 20),
              child: nameTitle("Maiden Name"),
            ),
            textField(_maidenNameController, maidenName, null, null, false),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 20),
              child: nameTitle("Change Email"),
            ),
            textField(_emailController, email,
                const Icon(Icons.mail_outline_outlined), null, false),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 20),
              child: nameTitle("Age"),
            ),
            textField(_ageController, age.toString(), null, null, false),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 20),
              child: nameTitle("Change Phone"),
            ),
            textField(_phoneController, phone,
                const Icon(Icons.mail_outline_outlined), null, false),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 20),
              child: nameTitle("Gender"),
            ),
            editGender(),
            Padding(
              padding: const EdgeInsets.only(bottom: 13, top: 30),
              child: InkWell(
                onTap: () {
                  context1.read<UserBloc>().add(UserEditingProfileEvent(
                        user: widget.user,
                        firstName: _firstNameController.text,
                        maidenName: _maidenNameController.text,
                        gender: _selectedValue!,
                        age: int.parse(_ageController.text),
                        phone: _phoneController.text,
                        email: _emailController.text,
                      ));
                },
                child: Container(
                  alignment: AlignmentDirectional.center,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.blue[400]),
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  nameTitle(name) {
    return Text(
      name,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    );
  }

  editGender() {
    return DropdownButtonFormField<String>(
      focusColor: Colors.transparent,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      isExpanded: true,
      value: _selectedValue!.isEmpty ? null : _selectedValue,
      // hint: Text(widget.user.gender),
      items: <String>['Male', 'Female', 'Other']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedValue = newValue;
        });
      },
    );
  }

  textField(controller, hinText, prefixIcon, suffixIcon, hide) {
    return SizedBox(
      height: 48,
      child: TextFormField(
        obscureText: hide,
        controller: controller,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 55, left: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            prefixIcon: prefixIcon,
            hintText: hinText,
            suffixIcon: suffixIcon,
            hintStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black38)),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _firstNameController.dispose();
    _maidenNameController.dispose();
  }
}
