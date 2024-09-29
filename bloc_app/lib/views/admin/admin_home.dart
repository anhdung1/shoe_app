import 'package:bloc_app/models/user_data_model.dart';
import 'package:bloc_app/views/admin/add_product.dart';
import 'package:bloc_app/views/admin/fitler.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key, required this.user});
  final UserDataModel user;
  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ADMIN",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 0.2,
              color: Colors.black45,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: GridView(
                  padding: const EdgeInsets.only(left: 5, right: 5, top: 20),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3 / 1, crossAxisCount: 1),
                  children: [
                    featureButton(
                        "Find By UserName", Icons.account_circle, () {}),
                    featureButton("Find By Code Order", Icons.code_sharp, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Fitler(),
                          ));
                    }),
                    featureButton("Add Product", Icons.add, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddProduct(),
                          ));
                    }),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  featureButton(name, icon, onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3, bottom: 6),
      child: InkWell(
          onTap: onTap,
          child: Container(
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.green],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
                Text(
                  name,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          )),
    );
  }
}
