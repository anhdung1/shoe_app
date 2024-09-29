import 'dart:ui';

import 'package:bloc_app/bloc/order_bloc/order_bloc.dart';
import 'package:bloc_app/bloc/order_bloc/order_event.dart';
import 'package:bloc_app/bloc/order_bloc/order_state.dart';

import 'package:bloc_app/views/custom_pain/dashed_line.dart';
import 'package:bloc_app/views/user/order_details.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc()..add(OrderFetchingEvent()),
      child: OrderPage(),
    );
  }
}

class OrderPage extends StatelessWidget {
  OrderPage({super.key});
  final ScrollController _scrollController = ScrollController();
  final TextStyle styleCode =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w700);
  final TextStyle styleContent =
      const TextStyle(fontSize: 12, color: Colors.black54);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text("Order"),
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch}),
        child: BlocConsumer<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderFetchingSuccessState) {
              return listOrder(_scrollController, context, state);
            }

            if (state is OrderLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const SizedBox();
          },
          listener: (context, state) {},
        ),
      ),
    );
  }

  listOrder(
      scrollController, BuildContext context, OrderFetchingSuccessState state) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      controller: scrollController,
      itemCount: state.orders.length,
      itemBuilder: (context, index) {
        return orderTable(context, state, index);
      },
    );
  }

  orderTable(BuildContext context, OrderFetchingSuccessState state, int index) {
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
      child: InkWell(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OrderDetails(
                        order: state.orders[index],
                      )));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 130,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: Border.all(width: 0.5, color: Colors.black26)),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.orders[index].code,
                  style: styleCode,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 5),
                  child: DashedLine(
                    height: 0,
                  ),
                ),
                bill("Order Status", state.orders[index].status, Colors.black),
                bill("Price", "\$${state.orders[index].totalAmount}",
                    Colors.blue[400])
              ],
            ),
          ),
        ),
      ),
    );
  }

  bill(name, price, color) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Text(
            name,
            style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
          ),
          const Expanded(child: SizedBox()),
          Text(
            price,
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 14, color: color),
          )
        ],
      ),
    );
  }
}
