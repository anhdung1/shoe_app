import 'dart:ui';

import 'package:bloc_app/bloc/cart_bloc/cart_bloc.dart';
import 'package:bloc_app/bloc/cart_bloc/cart_event.dart';

import 'package:bloc_app/bloc/cart_bloc/cart_state.dart';
import 'package:bloc_app/local_variable.dart';
import 'package:bloc_app/models/user_data_model.dart';
import 'package:bloc_app/views/user/myhome.dart';
import 'package:bloc_app/views/user/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatefulWidget {
  const Cart(
      {super.key,
      required this.user,
      required this.totalCartBloc,
      required this.cartBloc});
  final UserDataModel user;
  final CartBloc totalCartBloc;
  final CartBloc cartBloc;
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  Color color = Colors.white;

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartBloc>(
        create: (context) => CartBloc(),
        child: Scaffold(
          backgroundColor: color,
          body: BlocConsumer<CartBloc, CartState>(
            bloc: widget.totalCartBloc,
            builder: (context, state) {
              if (state is CartLoadingProductState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CartSuccessProductState) {
                return listProduct(state, context);
              }
              if (state is CartPaySuccessState) {
                return paySuccessState(
                    "Success",
                    "thank you for shopping using lafyuu",
                    Icons.check,
                    "Back To Order", () {
                  widget.totalCartBloc
                      .add(CartFetchingProductEvent(userId: userId));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Order()),
                  );
                });
              }
              if (state is CartPayErrorState) {
                return const SizedBox(
                  child: Text("Error"),
                );
              }
              if (state is CartEmptyState) {
                return paySuccessState(
                    "You haven't ordered anything yet",
                    "thank you for shopping using lafyuu",
                    Icons.shopify_rounded,
                    "Go To Home", () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHome(userDataModel: widget.user),
                    ),
                    (Route<dynamic> route) => false,
                  );
                });
              }
              return const SizedBox();
            },
            listener: (context, state) {},
          ),
        ));
  }

  paySuccessState(String title, String content, icon, nameButton, onTap) {
    return Container(
      alignment: AlignmentDirectional.center,
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36),
                color: Colors.blue[400]),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Text(
              content,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
          InkWell(
              onTap: onTap,
              child: Container(
                alignment: AlignmentDirectional.center,
                width: MediaQuery.of(context).size.width,
                height: 57,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.blue[400]),
                child: Text(
                  nameButton,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              ))
        ],
      ),
    );
  }

  listProduct(stateTotal, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Expanded(
            child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.mouse,
                      PointerDeviceKind.touch
                    }),
                child: ListView.builder(
                  controller: _scrollController,
                  // padding: const EdgeInsets.only(left: 10, right: 10),
                  scrollDirection: Axis.vertical,
                  itemCount: stateTotal.cart.length,
                  itemBuilder: (context, index) {
                    return product(
                        stateTotal.cart[index].productTitle,
                        stateTotal.cart[index].productPrice,
                        stateTotal.cart[index].productImage,
                        stateTotal.cart[index].quantity,
                        stateTotal.cart[index].productId);
                  },
                )),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 30)),
          BlocBuilder<CartBloc, CartState>(
            bloc: widget.cartBloc,
            builder: (contextProduct, state) {
              if (state is CartIntitalProductState) {
                return checkButton(() {
                  widget.cartBloc.add(CartCheckOutEvent(userName: userName));
                });
              }
              if (state is CartLoadingProductState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CartCheckOutState) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 160,
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: Colors.black26),
                          borderRadius: BorderRadius.circular(7)),
                      child: Column(
                        children: [
                          bill("Items", "\$${state.price}"),
                          bill("ship", "\$40.00"),
                          bill("Import charges", "\$128.00"),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, top: 15),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black45, width: 0.1)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: Row(
                              children: [
                                const Text(
                                  "Total Price",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Expanded(child: SizedBox()),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    " \$${state.price + 40 + 128}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.blue[400]),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    checkButton(() {
                      widget.totalCartBloc.add(CartPayEvent(
                          totalAmount: state.price, carts: stateTotal.cart));
                    }),
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  bill(name, price) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: Row(
        children: [
          Text(
            name,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              price,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  checkButton(onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: AlignmentDirectional.center,
        width: MediaQuery.of(context).size.width,
        height: 57,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(7)),
        child: const Text(
          "Check Out",
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  product(title, price, image, int quantity, productId) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      height: 104,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: Colors.black12, width: 1)),
      child: Row(
        children: [
          Container(
            height: 90,
            padding: const EdgeInsets.only(left: 10),
            child: Image.network(
              image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Text("error"),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "\$$price",
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.blue,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 105,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 12, bottom: 20, right: 10),
                  child: InkWell(
                    onTap: () {
                      widget.totalCartBloc.add(CartRemoveProductEvent(
                          productId: productId, userId: widget.user.id));
                    },
                    child: const Icon(Icons.recycling_sharp),
                  ),
                ),
                Container(
                    alignment: AlignmentDirectional.center,
                    margin: const EdgeInsets.only(right: 10),
                    height: 26,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 233, 227, 255)),
                    child: BlocProvider(
                      create: (context) => CartBloc()
                        ..add(ProductFetchingEvent(quantity: quantity)),
                      child: BlocBuilder<CartBloc, CartState>(
                          builder: (context1, count) {
                        if (count is ProductChangeQuantityState) {
                          return Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  context1.read<CartBloc>().add(
                                      ProductDecrementQuantityEvent(
                                          quantity: count.quantity,
                                          productId: productId,
                                          cartBloc: widget.cartBloc));
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(left: 1),
                                    width: 32,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Icon(Icons.remove)),
                              ),
                              Expanded(
                                  child: Center(
                                      child: Text(count.quantity.toString()))),
                              InkWell(
                                onTap: () {
                                  context1.read<CartBloc>().add(
                                      ProductIncrementQuantityEvent(
                                          quantity: count.quantity,
                                          productId: productId,
                                          cartBloc: widget.cartBloc));
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(left: 1),
                                    width: 32,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Icon(Icons.add)),
                              )
                            ],
                          );
                        }
                        return const SizedBox();
                      }),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // cartBloc.close();
    // widget.totalCartBloc.close();
  }
}

// class BillWidget extends StatelessWidget {
//   const BillWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }
