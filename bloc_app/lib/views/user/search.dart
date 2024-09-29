import 'dart:ui';

import 'package:bloc_app/bloc/cart_bloc/cart_bloc.dart';
import 'package:bloc_app/bloc/search_bloc/search_bloc.dart';
import 'package:bloc_app/bloc/search_bloc/search_event.dart';
import 'package:bloc_app/bloc/search_bloc/search_state.dart';
import 'package:bloc_app/views/user/productdetails.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatefulWidget {
  final CartBloc totalCartBloc;
  const Search({super.key, required this.totalCartBloc});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final SearchBloc _searchBloc = SearchBloc();
  final TextEditingController _searchController = TextEditingController();
  var padding = const Padding(padding: EdgeInsets.only(bottom: 10));
  Color borderColor = Colors.black26;
  var orientation = Orientation.portrait;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int screenWidth = ((MediaQuery.of(context).size.width) / 300).toInt() + 1;
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: Scaffold(
        body: BlocConsumer<SearchBloc, SearchState>(
          bloc: _searchBloc,
          builder: (BuildContext context, state) {
            if (state is SearchIntitalState) {
              return findBar();
            }
            if (state is SearchLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is SearchSuccessState) {
              return successState(state, screenWidth, _searchController.text);
            }
            if (state is SearchErrorNotFoundState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  findBar(),
                  const Padding(
                    padding: EdgeInsets.only(left: 10, top: 20),
                    child: Text(
                      "0 results",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.only(left: 40, right: 40),
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      state.error,
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                  ))
                ],
              );
            }
            return const SizedBox();
          },
          listener: (context, state) {},
        ),
      ),
    );
  }

  successState(SearchSuccessState state, aspectRatio, controller) {
    return Column(
      children: [
        findBar(),
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "${state.products.length} results",
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
        Expanded(
          child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch
              }),
              child: GridView.builder(
                padding: const EdgeInsets.only(right: 10),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return productFrame(
                      state.products[index].imagenetwork,
                      state.products[index].title,
                      state.products[index].category.name,
                      state.products[index].price, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Productdetails(
                            productDataModel: state.products[index],
                            totalCartBLoc: widget.totalCartBloc,
                          ),
                        ));
                  }, state.products[index].rate, state.products[index].count);
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 3 / 5, crossAxisCount: aspectRatio),
              )),
        )
      ],
    );
  }

  productFrame(image, title, category, price, onTap, rate, count) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 10),
      height: 278,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 247, 247, 247),
              border: Border.all(width: 0.3, color: borderColor),
              borderRadius: BorderRadius.circular(3)),
          width: 141,
          height: 238,
          child: Column(
            children: [
              padding,
              padding,
              Container(
                width: 109,
                height: 109,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: SizedBox(
                  width: 40,
                  child: Image.network(
                    image,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text("error");
                    },
                  ),
                ),
              ),
              padding,
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RatingBar.readOnly(
                          filledIcon: Icons.star,
                          size: 15,
                          emptyIcon: Icons.star_border,
                          maxRating: 5,
                          initialRating: rate,
                        ),
                        const Padding(padding: EdgeInsets.only(right: 10)),
                        Text('$count')
                      ],
                    ),
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text(category),
                    padding,
                    Text(
                      "$price \$",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue[300]),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  findBar() {
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
              _searchBloc
                  .add(SearchFetchingEvent(title: _searchController.text));
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

  @override
  void dispose() {
    super.dispose();
    // widget.totalCartBloc.close();
    _searchBloc.close();
    _searchController.clear();
  }
}
