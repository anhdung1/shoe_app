import 'package:bloc_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:bloc_app/models/user_data_model.dart';

import 'package:bloc_app/views/login.dart';
import 'package:bloc_app/views/user/myhome.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(const MyApp());
}

// ProductDataModel productDataModel = ProductDataModel(
//     price: 10.0,v
//     title: "aaaa",
//     description: "aaaa",
//     category: "",
//     imagenetwork: "",
//     rating: {"rate": 4.3});
UserDataModel user = UserDataModel(
    id: 9,
    roles: [],
    firstName: "",
    maidenName: "",
    age: 1,
    phone: "",
    username: "dungvl76",
    password: "",
    image: "",
    email: "",
    gender: "");

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        lazy: false,
        create: (context) => AuthBloc(),
        child: MyHome(
          userDataModel: user,
        ),
      ),
    );
  }
}
