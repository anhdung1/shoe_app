import 'package:bloc_app/bloc/pagehome_bloc/pagehome_bloc.dart';
import 'package:bloc_app/bloc/pagehome_bloc/pagehome_event.dart';
import 'package:bloc_app/bloc/pagehome_bloc/pagehome_state.dart';

import 'package:bloc_app/models/user_data_model.dart';
import 'package:bloc_app/views/admin/admin_home.dart';

import 'package:bloc_app/views/user/order.dart';

import 'package:bloc_app/views/user/user_information.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class Admin extends StatefulWidget {
  const Admin({super.key, required this.userDataModel});
  final UserDataModel userDataModel;

  @override
  State<Admin> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Admin> {
  List<BottomNavigationBarItem> items = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explore"),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart_rounded), label: "Cart"),
    BottomNavigationBarItem(
        icon: Icon(Icons.local_offer_outlined), label: "Offer"),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_circle_sharp), label: "Account")
  ];

  var borderColor = Colors.black26;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => PagehomeBloc())],
      child: BlocBuilder<PagehomeBloc, PagehomeState>(
        builder: (context, state) {
          return initHomePage(state, context);
        },
      ),
    );
  }

  initHomePage(PagehomeState state, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.white,
        toolbarHeight: 10,
        leading: const SizedBox(),
      ),
      body: [
        AdminHome(
          user: widget.userDataModel,
        ),
        const Text(""),
        const Text(""),
        const Text(""),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                "Account",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 0.3,
              color: Colors.black38,
            ),
            moreInfoButon(Icons.account_circle, "Profile", () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserInformation(
                            user: widget.userDataModel,
                          )));
            }),
            moreInfoButon(Icons.badge, "Order", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Order()),
              );
            }),
            moreInfoButon(Icons.location_on, "Address", () {}),
            moreInfoButon(Icons.credit_card, "Payment", () {}),
          ],
        )
      ][state.tabIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black38,
        items: items,
        currentIndex: state.tabIndex,
        onTap: (value) {
          context.read<PagehomeBloc>().add(PageSelectEvent(tabIndex: value));
        },
      ),
    );
  }

  moreInfoButon(icon, nameButton, onTap) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: SizedBox(
        height: 56,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Icon(
                icon,
                color: Colors.blue[400],
              ),
            ),
            Text(
              nameButton,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
