import 'dart:ui';

import 'package:bloc_app/bloc/cart_bloc/cart_bloc.dart';
import 'package:bloc_app/bloc/cart_bloc/cart_event.dart';
import 'package:bloc_app/bloc/cart_bloc/cart_state.dart';
import 'package:bloc_app/local_variable.dart';
import 'package:bloc_app/models/product_data_model.dart';

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Productdetails extends StatefulWidget {
  const Productdetails(
      {super.key, required this.productDataModel, required this.totalCartBLoc});
  final ProductDataModel productDataModel;

  final CartBloc totalCartBLoc;
  @override
  State<Productdetails> createState() => _ProductdetailsState();
}

class _ProductdetailsState extends State<Productdetails> {
  final CartBloc cartBloc = CartBloc();
  int select = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.productDataModel.title,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: initPageState(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            cartBloc.add(CartAddProductEvent(
                userId: userId,
                producId: widget.productDataModel.id,
                userName: userName,
                widget.totalCartBLoc));
          },
          child: Container(
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.blue,
            ),
            child: const Text(
              "Add To Cart",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  initPageState() {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Center(
                    child: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: 238,
                      child: Image.network(
                        widget.productDataModel.imagenetwork,
                        fit: BoxFit.scaleDown,
                        errorBuilder: (context, error, stackTrace) {
                          return const Text("error");
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 243,
                    child: Column(
                      children: [
                        const Expanded(child: SizedBox()),
                        Container(
                          width: 145,
                          height: 10,
                          decoration: const BoxDecoration(
                              color: Colors.transparent,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 9,
                                    spreadRadius: 1,
                                    color: Colors.black45)
                              ],
                              borderRadius: BorderRadius.all(
                                  Radius.elliptical(1000, 100))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Text(
                  widget.productDataModel.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 15, left: 10, right: 10),
                child: RatingBar.readOnly(
                  filledIcon: Icons.star,
                  size: 15,
                  emptyIcon: Icons.star_border,
                  maxRating: 5,
                  initialRating: widget.productDataModel.rate,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  "\$${widget.productDataModel.price}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue[400]),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Text(
                  "Select Size",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: listSize(),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Description",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Text(widget.productDataModel.description),
              )
            ],
          ),
          BlocBuilder<CartBloc, CartState>(
              bloc: cartBloc,
              builder: (context, state) {
                if (state is CartIntitalProductState) {
                  return const SizedBox();
                }
                if (state is CartLoadingProductState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is CartAddSuccessProductState) {
                  return InkWell(
                      onTap: () {
                        cartBloc.add(CartBackInitialEvent());
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: const Color.fromARGB(79, 239, 239, 239),
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 100),
                            width: 250,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color:
                                    const Color.fromRGBO(106, 106, 106, 0.78)),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Product added successfully",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Icon(
                                    Icons.check_circle,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
                }
                if (state is CartAddErrorProductState) {
                  return InkWell(
                      onTap: () {
                        context.read<CartBloc>().add(CartBackInitialEvent());
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: const Color.fromARGB(79, 239, 239, 239),
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 100),
                            width: 250,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color:
                                    const Color.fromRGBO(106, 106, 106, 0.78)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  state.error,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Icon(
                                    Icons.highlight_remove_outlined,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
                }
                return const SizedBox();
              })
        ],
      ),
    );
  }

  listSize() {
    return SizedBox(
      height: 40,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch}),
        child: StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return ListView.builder(
              padding: const EdgeInsets.only(left: 10, right: 10),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      setState(
                        () {
                          select = index;
                        },
                      );
                    },
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color:
                                select == index ? Colors.blue : Colors.black12,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "${6 + index / 2}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 12),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // widget.totalCartBLoc.close();
  }
}
