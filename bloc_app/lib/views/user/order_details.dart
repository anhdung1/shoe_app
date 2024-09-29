import 'dart:ui';

import 'package:bloc_app/bloc/order_details_bloc/order_details_bloc.dart';
import 'package:bloc_app/bloc/order_details_bloc/order_details_event.dart';
import 'package:bloc_app/bloc/order_details_bloc/order_details_state.dart';
import 'package:bloc_app/models/orders_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key, required this.order});

  final OrdersDataModel order;
  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order Details",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch}),
          child: BlocProvider(
            create: (context) => OrderDetailsBloc(OrderLoadingState())
              ..add(OrderDetailsFetchingEvent(
                  code: widget.order.code, status: widget.order.status)),
            child: BlocBuilder<OrderDetailsBloc, OrderDetailsState>(
              builder: (context, state) {
                if (state is OrderLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is OrderDetailsFetchingErrorState) {
                  return const Center(
                    child: Text("Error"),
                  );
                }
                if (state is OrderDetailsFetchingSuccessState) {
                  return Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.mouse,
                            PointerDeviceKind.touch
                          }),
                      child: ListView(
                        controller: _scrollController,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          Row(
                            children: [
                              const Padding(padding: EdgeInsets.only(left: 10)),
                              status(state, 0),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: state.number < 1
                                      ? Colors.black12
                                      : Colors.blue,
                                ),
                              ),
                              status(state, 1),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: state.number < 2
                                      ? Colors.black12
                                      : Colors.blue,
                                ),
                              ),
                              status(state, 2),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: state.number < 3
                                      ? Colors.black12
                                      : Colors.blue,
                                ),
                              ),
                              status(state, 3),
                              const Padding(
                                  padding: EdgeInsets.only(right: 10)),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 10)),
                          const Row(
                            children: [
                              Text("Packing"),
                              Expanded(child: SizedBox()),
                              Text("Shipping"),
                              Expanded(child: SizedBox()),
                              Text("Arriving"),
                              Expanded(child: SizedBox()),
                              Text("Success"),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: title("Product"),
                          ),
                          listProduct(state, context),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: title("Payment Details"),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10, top: 10),
                            height: 160,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5, color: Colors.black26),
                                borderRadius: BorderRadius.circular(7)),
                            child: Column(
                              children: [
                                bill("Items", "\$${widget.order.totalAmount}"),
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
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 10),
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
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Text(
                                          " \$${double.parse(widget.order.totalAmount) + 40 + 128}",
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
                          InkWell(
                            onTap: () {},
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Container(
                              alignment: AlignmentDirectional.center,
                              height: 55,
                              decoration: BoxDecoration(
                                  color: Colors.blue[400],
                                  borderRadius: BorderRadius.circular(7)),
                              width: MediaQuery.of(context).size.width,
                              child: const Text(
                                "Notify Me",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 10))
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          )),
    );
  }

  title(title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    );
  }

  listProduct(OrderDetailsFetchingSuccessState state, BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < state.orderItems.length; i++)
          product(
              state.orderItems[i].productTitle,
              state.orderItems[i].productPrice,
              state.orderItems[i].productImage,
              context)
      ],
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

  product(title, price, image, BuildContext context) {
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
            height: 80,
            padding: const EdgeInsets.only(left: 15, top: 3, bottom: 3),
            child: Image.network(
              image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Text("error"),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 30, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
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
        ],
      ),
    );
  }

  status(OrderDetailsFetchingSuccessState state, number) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: state.number < number ? Colors.black12 : Colors.blue,
      ),
      child: const Icon(
        Icons.check,
        size: 16,
        color: Colors.white,
      ),
    );
  }
}
