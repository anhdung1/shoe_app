import 'dart:ui';

import 'package:bloc_app/bloc/admin/admin_product_bloc/admin_product_bloc.dart';
import 'package:bloc_app/bloc/admin/admin_product_bloc/admin_product_event.dart';
import 'package:bloc_app/bloc/admin/admin_product_bloc/admin_product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  AdminProductBloc bloc = AdminProductBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => AdminProductBloc(),
        child: BlocBuilder<AdminProductBloc, AdminProductState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is AdminAddProductInitialState) {
              return initScreen();
            }
            if (state is AdminAddProductLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is AdminAddProductErrorState) {
              return const Text("Error");
            }
            if (state is AdminAddProductSuccessState) {
              return initScreen();
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  initScreen() {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch}),
      child: ListView(
        padding: const EdgeInsets.only(left: 10, right: 10),
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: nameTitle("Link image"),
          ),
          textField(
            _imageController,
            "image",
            const Icon(Icons.image),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 20),
            child: nameTitle("Title"),
          ),
          textField(
            _titleController,
            "title",
            const Icon(Icons.title),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 20),
            child: nameTitle("Description"),
          ),
          textField(
            _descriptionController,
            "description",
            const Icon(Icons.mail_outline_outlined),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 20),
            child: nameTitle("Price"),
          ),
          textField(
            _priceController,
            "price",
            const Icon(Icons.price_change_outlined),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 20),
            child: nameTitle("Category"),
          ),
          textField(
            _categoryController,
            "category",
            const Icon(Icons.category),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 13, top: 30),
            child: InkWell(
              onTap: () {
                bloc.add(AdminAddProductEvent(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    image: _imageController.text,
                    price: _priceController.text,
                    category: _categoryController.text));
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
    );
  }

  nameTitle(name) {
    return Text(
      name,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    );
  }

  textField(controller, hinText, prefixIcon) {
    return SizedBox(
      height: 48,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 55, left: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            prefixIcon: prefixIcon,
            hintText: hinText,
            hintStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black38)),
      ),
    );
  }
}
