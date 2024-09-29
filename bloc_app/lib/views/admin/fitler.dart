import 'package:bloc_app/bloc/admin/admin_edit_status_bloc/admin_edit_status_bloc.dart';
import 'package:bloc_app/bloc/admin/admin_edit_status_bloc/admin_edit_status_event.dart';
import 'package:bloc_app/bloc/admin/admin_edit_status_bloc/admin_edit_status_state.dart';
import 'package:bloc_app/bloc/admin/admin_filter_bloc/admin_filter_bloc.dart';
import 'package:bloc_app/bloc/admin/admin_filter_bloc/admin_filter_event.dart';
import 'package:bloc_app/bloc/admin/admin_filter_bloc/admin_filter_state.dart';
import 'package:bloc_app/views/custom_pain/dashed_line.dart';
import 'package:bloc_app/views/user/order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Fitler extends StatelessWidget {
  const Fitler({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminFilterBloc(),
      child: const FitlerPage(),
    );
  }
}

class FitlerPage extends StatefulWidget {
  const FitlerPage({super.key});

  @override
  State<FitlerPage> createState() => _FitlerPageState();
}

class _FitlerPageState extends State<FitlerPage> {
  String? _selectedValue;
  final Color borderColor = Colors.black26;
  final TextEditingController _searchController = TextEditingController();
  final TextStyle styleCode =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: findBar(context),
          ),
          BlocConsumer<AdminFilterBloc, AdminFilterState>(
            builder: (context, state) {
              if (state is AdminFilterInititalState) {
                return const SizedBox();
              }
              if (state is AdminFilterSuccessState) {
                _selectedValue = state.order.status;
                return orderTable(context, state);
              }
              if (state is AdminFilterErrorState) {
                return Expanded(
                  child: Center(
                    child: Text(
                      state.error,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
            listener: (context, state) {},
          )
        ],
      ),
    );
  }

  orderTable(BuildContext context, AdminFilterSuccessState state) {
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
                        order: state.order,
                      )));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: Border.all(width: 0.5, color: Colors.black26)),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.order.code,
                  style: styleCode,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 5),
                  child: DashedLine(
                    height: 0,
                  ),
                ),
                bill("Order Status", "", Colors.black, true, "",
                    state.order.code),
                bill("Price", "\$${state.order.totalAmount}", Colors.blue[400],
                    false, state.order.status, state.order.code)
              ],
            ),
          ),
        ),
      ),
    );
  }

  bill(name, price, color, bool hide, status, code) {
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
          ),
          if (hide)
            BlocProvider(
              create: (context) => AdminEditStatusBloc(
                  AdminEditStatusSuccessState(status: status)),
              child: BlocBuilder<AdminEditStatusBloc, AdminEditStatusState>(
                builder: (context, state) {
                  if (state is AdminEditStatusSuccessState) {
                    return SizedBox(
                      width: 90,
                      child: DropdownButtonFormField<String>(
                        focusColor: Colors.transparent,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        value: _selectedValue!.isEmpty ? null : _selectedValue,
                        items: <String>[
                          'Packing',
                          'Shipping',
                          'Arriving',
                          'Success'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedValue = newValue;
                            context.read<AdminEditStatusBloc>().add(
                                AdminOnEditStatusEvent(
                                    status: newValue!, code: code));
                          });
                        },
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            )
        ],
      ),
    );
  }

  findBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
      child: Row(
        children: [
          Expanded(
              child: SizedBox(
            height: 46,
            child: TextField(
              autofocus: true,
              controller: _searchController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide:
                          const BorderSide(width: 0.1, color: Colors.black38)),
                  contentPadding: const EdgeInsets.only(top: 9),
                  hintText: "Search Product",
                  hintStyle: TextStyle(color: borderColor),
                  prefixIcon: const Icon(Icons.search)),
            ),
          )),
          const Padding(padding: EdgeInsets.only(right: 10)),
          InkWell(
            child: Icon(
              Icons.sort,
              size: 24,
              color: borderColor,
            ),
          ),
          const Padding(padding: EdgeInsets.only(right: 10)),
          InkWell(
            onTap: () {
              context
                  .read<AdminFilterBloc>()
                  .add(AdminFitlerOrderEvent(code: _searchController.text));
            },
            child: Icon(
              Icons.filter_alt_outlined,
              size: 24,
              color: Colors.blue[300],
            ),
          )
        ],
      ),
    );
  }
}
