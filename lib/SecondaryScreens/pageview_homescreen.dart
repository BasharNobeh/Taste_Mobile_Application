import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:provider/provider.dart';
import 'package:taste_application/SecondaryScreens/circle_retaurants.dart';
import 'package:taste_application/SecondaryScreens/meal_view.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:taste_application/models/restaurant.dart';

import '../provider_files/taste_provider.dart';
import '4buttons_hc.dart';

class PageViewHomeScreen extends StatefulWidget {
  const PageViewHomeScreen({super.key});

  @override
  State<PageViewHomeScreen> createState() => _PageViewHomeScreenState();
}

class _PageViewHomeScreenState extends State<PageViewHomeScreen> {
  LoopPageController contoller = LoopPageController(viewportFraction: 0.85);
  int currentPage = 0;
  Timer? _timer;
  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 15), (Timer timer) {
      if (currentPage < context.read<TasteProvider>().taste_Meals.length) {
        currentPage++;
        contoller.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 4000),
          curve: Curves.easeIn,
        );
      } else {
        currentPage = -1;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
    contoller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 320,
            child: LoopPageView.builder(
              controller: contoller,
              onPageChanged: (value) => setState(() {
                currentPage = value;
              }),
              itemCount: context.watch<TasteProvider>().taste_Meals.length,
              itemBuilder: (context, position) {
                Restaurant restaurant = restuarantFinder(context
                    .watch<TasteProvider>()
                    .taste_Meals[position]
                    .restaurantId);
                return InkWell(
                  onTap: () {
                    context.read<TasteProvider>().UpdateSelectedMeal(
                        context.read<TasteProvider>().taste_Meals[position]);
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 800),
                            transitionsBuilder: (_, a, __, c) =>
                                FadeTransition(opacity: a, child: c),
                            pageBuilder: (_, __, ___) =>
                                const Material(child: TasteMealViewPage())));
                  },
                  child: Stack(children: [
                    Container(
                      height: 220,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(context
                                  .watch<TasteProvider>()
                                  .taste_Meals[position]
                                  .imageUrl)),
                          borderRadius: BorderRadius.circular(20),
                          color: position.isEven
                              ? const Color(0xFF69c5df)
                              : const Color.fromARGB(255, 181, 132, 227)),
                      width: double.infinity,
                      margin:
                          const EdgeInsets.only(top: 30, left: 15, right: 15),
                      child: Column(children: [
                        Container(
                            margin: const EdgeInsets.only(bottom: 0, top: 120),
                            width: 400,
                            height: 100,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                color: Color.fromARGB(168, 0, 0, 0)),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 15, left: 15, right: 15),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      context
                                          .watch<TasteProvider>()
                                          .taste_Meals[position]
                                          .title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.restaurant_menu,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                              Text(
                                                restaurant.title,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Roboto',
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${context.watch<TasteProvider>().taste_Meals[position].price} JOD",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Roboto',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              color: Colors.blue[700],
                                            ),
                                            Text(
                                              restaurant.location,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Roboto',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ]),
                            )),
                      ]),
                    ),
                  ]),
                );
              },
            ),
          ),
          SizedBox(
            width: 150,
            height: 10,
            child: PageViewDotIndicator(
              currentItem: currentPage,
              count: context.watch<TasteProvider>().taste_Meals.length,
              unselectedColor: Colors.black26,
              selectedColor: Theme.of(context).colorScheme.primary,
              size: const Size(12, 12),
              unselectedSize: const Size(8, 8),
              duration: const Duration(milliseconds: 400),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              fadeEdges: false,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 120,
            child: TasteCircleRetaurants(),
          ),
          Container(
            height: 220,
            margin: const EdgeInsets.only(top: 20),
            child: const BottomPartHomePage(),
          )
        ],
      ),
    );
  }

  Restaurant restuarantFinder(String resID) {
    Restaurant restaurant = context
        .watch<TasteProvider>()
        .taste_Restaurants
        .firstWhere((element) => element.id == resID);

    return restaurant;
  }
}
