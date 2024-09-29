import 'package:bloc_app/models/user_data_model.dart';
import 'package:bloc_app/views/user/password_editing.dart';
import 'package:bloc_app/views/user/user_editing.dart';
import 'package:flutter/material.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key, required this.user});
  final UserDataModel user;
  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black38,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(44),
                      child: Image.network(
                        widget.user.image,
                        width: 72,
                        errorBuilder: (context, error, stackTrace) {
                          return const Text("error");
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "${widget.user.firstName} ${widget.user.maidenName}",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            itemInProfile("Gender", Icons.female, widget.user.gender),
            itemInProfile("Age", Icons.calendar_month_rounded, widget.user.age),
            itemInProfile("Email", Icons.email_rounded, widget.user.email),
            itemInProfile("Phone Number", Icons.call, widget.user.phone),
            itemInProfile("Change Password", Icons.lock, "**********"),
            const Expanded(child: SizedBox()),
            Row(
              children: [
                editingButton(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UserEditing(user: widget.user)));
                }, "Edit"),
                editingButton(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PasswordEditingPage(
                                id: widget.user.id,
                              )));
                }, "Edit Password"),
              ],
            )
          ],
        ),
      ),
    );
  }

  editingButton(onTap, name) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 15, left: 5, bottom: 20),
        child: InkWell(
          onTap: onTap,
          child: Container(
            alignment: AlignmentDirectional.center,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.blue[400]),
            child: Text(
              name,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  itemInProfile(nameItem, icon, nameItemModel) {
    return SizedBox(
      height: 54,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.blue[400],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              nameItem,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
          ),
          const Expanded(child: SizedBox()),
          Text(
            nameItemModel.toString(),
            style: const TextStyle(
                fontSize: 12,
                color: Colors.black45,
                fontWeight: FontWeight.w500),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
          )
        ],
      ),
    );
  }
}
