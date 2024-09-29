import 'dart:ui';

import 'package:bloc_app/bloc/cart_bloc/cart_bloc.dart';
import 'package:bloc_app/bloc/pagehome_bloc/pagehome_bloc.dart';
import 'package:bloc_app/bloc/pagehome_bloc/pagehome_event.dart';
import 'package:bloc_app/bloc/product_bloc/product_bloc.dart';
import 'package:bloc_app/bloc/product_bloc/product_event.dart';
import 'package:bloc_app/bloc/product_bloc/product_state.dart';
import 'package:bloc_app/bloc/timer_bloc/timer_bloc.dart';
import 'package:bloc_app/bloc/timer_bloc/timer_state.dart';
import 'package:bloc_app/views/user/productdetails.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.totalCartBloc});
  final CartBloc totalCartBloc;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _mainScrollController = ScrollController();
  final ScrollController _scrollController = ScrollController();
  List<String> image = [
    "bag.png",
    "handbag.png",
    "humanshirt.png",
    "manshirt.png",
    "shoes.png"
  ];
  Color borderColor = Colors.black26;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: findBar(),
        ),
        Expanded(
          child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch
              }),
              child: ListView(
                controller: _mainScrollController,
                children: <Widget>[
                  SizedBox(
                    child: BlocBuilder<CountdownBloc, CountdownState>(
                      builder: (context, state) {
                        if (state is CountdownRunInProgress) {
                          final String hoursStr =
                              ((state.duration / 3600).floor())
                                  .toString()
                                  .padLeft(2, '0');

                          final String minutesStr =
                              ((state.duration / 60).floor() -
                                      (state.duration / 3600).floor() * 60)
                                  .toString()
                                  .padLeft(2, '0');
                          final String secondsStr =
                              (state.duration % 60).toString().padLeft(2, '0');
                          return superPlashSaleFrame(
                              () {}, hoursStr, minutesStr, secondsStr);
                        } else if (state is CountdownRunComplete) {
                          return const SizedBox();
                        }
                        return Container();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: seeMore("Category", "More Category", () {}),
                  ),
                  SizedBox(
                    height: 95,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: image.length,
                        itemBuilder: (context, index) {
                          return listCategory("assets/images/${image[index]}",
                              () {}, name[index]);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: seeMore("FlashSale", "See More", () {}),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 5)),
                  SizedBox(
                    height: 238,
                    child: BlocConsumer<ProductBloc, ProductState>(
                        builder: (context, state) {
                          switch (state.runtimeType) {
                            case const (ProductFetchingLoadingState):
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            case const (ProductFetchingSucessState):
                              final successState =
                                  state as ProductFetchingSucessState;
                              return ScrollConfiguration(
                                  behavior: ScrollConfiguration.of(context)
                                      .copyWith(dragDevices: {
                                    PointerDeviceKind.mouse,
                                    PointerDeviceKind.touch
                                  }),
                                  child: ListView.builder(
                                      // padding: EdgeInsets.only(left: 10),
                                      controller: _scrollController,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: successState.products.length,
                                      itemBuilder: (context, index) {
                                        return productFrame(
                                            successState
                                                .products[index].imagenetwork,
                                            successState.products[index].title,
                                            successState
                                                .products[index].category.name,
                                            successState.products[index].price,
                                            () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          Productdetails(
                                                            productDataModel:
                                                                successState
                                                                        .products[
                                                                    index],
                                                            totalCartBLoc: widget
                                                                .totalCartBloc,
                                                          )));
                                        },
                                            successState.products[index].rate
                                                .toDouble(),
                                            successState.products[index].count);
                                      }));
                            default:
                              return const SizedBox();
                          }
                        },
                        listener: (context, state) {}),
                  ),
                  seeMore("Mega Sale", "See More", () {
                    context.read<ProductBloc>().add(ProductAddEvent(
                          title: "hiha",
                          image: "image",
                        ));
                  }),
                  SizedBox(
                    height: 238,
                    child: BlocConsumer<ProductBloc, ProductState>(
                        builder: (context, state) {
                          switch (state.runtimeType) {
                            case const (ProductFetchingLoadingState):
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            case const (ProductFetchingSucessState):
                              final successState =
                                  state as ProductFetchingSucessState;
                              return ScrollConfiguration(
                                  behavior: ScrollConfiguration.of(context)
                                      .copyWith(dragDevices: {
                                    PointerDeviceKind.mouse,
                                    PointerDeviceKind.touch
                                  }),
                                  child: ListView.builder(
                                      // padding: EdgeInsets.only(left: 10),
                                      controller: _scrollController,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: successState.products.length,
                                      itemBuilder: (context, index) {
                                        return productFrame(
                                            successState
                                                .products[index].imagenetwork,
                                            successState.products[index].title,
                                            successState
                                                .products[index].category.name,
                                            successState.products[index].price,
                                            () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      Productdetails(
                                                          productDataModel:
                                                              successState
                                                                      .products[
                                                                  index],
                                                          totalCartBLoc: widget
                                                              .totalCartBloc)));
                                        },
                                            successState.products[index].rate
                                                .toDouble(),
                                            successState.products[index].count);
                                      }));
                            default:
                              return const SizedBox();
                          }
                        },
                        listener: (context, state) {}),
                  ),
                ],
              )),
        )
      ],
    );
  }

  productFrame(image, title, category, price, onTap, rate, count) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
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

  var padding = const Padding(padding: EdgeInsets.only(bottom: 10));
  seeMore(name, buttonName, onTap) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              name,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
          ),
          const Expanded(child: SizedBox()),
          InkWell(
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: onTap,
              child: Text(
                buttonName,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue[400]),
              ))
        ],
      ),
    );
  }

  superPlashSaleFrame(onTap, hoursStr, minutesStr, secondsStr) {
    return Container(
      // height: 206,
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                "assets/images/shoes_image.jpg",
                width: 700,
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Super Flash Sale\n50% Off ",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        timer(hoursStr),
                        const Padding(
                          padding: EdgeInsets.only(left: 3, right: 3),
                          child: Text(
                            ":",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        timer(minutesStr),
                        const Padding(
                          padding: EdgeInsets.only(left: 3, right: 3),
                          child: Text(
                            ":",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        timer(secondsStr),
                        const Padding(padding: EdgeInsets.only(right: 80)),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  timer(time) {
    return Container(
      alignment: AlignmentDirectional.center,
      height: 41,
      width: 41,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(3)),
      child: Text(
        time,
        style: const TextStyle(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
      ),
    );
  }

  findBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
              child: InkWell(
            onTap: () {
              context.read<PagehomeBloc>().add(PageSelectEvent(tabIndex: 1));
            },
            child: SizedBox(
              height: 46,
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(
                            width: 0.1, color: Colors.black38)),
                    contentPadding: const EdgeInsets.only(top: 9),
                    hintText: "Search Product",
                    hintStyle: TextStyle(color: borderColor),
                    prefixIcon: const Icon(Icons.search)),
              ),
            ),
          )),
          const Padding(padding: EdgeInsets.only(right: 10)),
          InkWell(
            child: Icon(
              Icons.favorite_border_rounded,
              size: 24,
              color: borderColor,
            ),
          ),
          const Padding(padding: EdgeInsets.only(right: 10)),
          InkWell(
            child: Icon(
              Icons.notifications_none_rounded,
              size: 24,
              color: borderColor,
            ),
          )
        ],
      ),
    );
  }

  listCategory(imageIcon, onTap, name) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: onTap,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(width: 0.4, color: borderColor)),
              child: Image.asset(
                imageIcon,
                scale: 2,
                errorBuilder: (context, error, stackTrace) {
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
        ),
        Container(
            padding: const EdgeInsets.only(left: 5),
            alignment: AlignmentDirectional.center,
            width: 70,
            child: Text(
              name,
              style: const TextStyle(
                  color: Colors.black38,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ))
      ],
    );
  }

  List<String> name = [
    "Man Shirt",
    "Dress",
    "Man Work Equipment",
    "Woman Bag",
    "Man Shoes"
  ];
}
