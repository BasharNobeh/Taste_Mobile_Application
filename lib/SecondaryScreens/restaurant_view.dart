import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taste_application/SecondaryScreens/cartpage.dart';
import 'package:taste_application/models/restaurant.dart';

import '../models/Meal.dart';
import '../provider_files/taste_provider.dart';

class TasteRestaurantView extends StatefulWidget {
  const TasteRestaurantView({super.key});

  @override
  State<TasteRestaurantView> createState() => _TasteRestaurantViewState();
}

class _TasteRestaurantViewState extends State<TasteRestaurantView> {
  @override
  Widget build(BuildContext context) {
    Restaurant restaurant = context.watch<TasteProvider>().selectedRestaurant;
    List<Meal> Meals = context.watch<TasteProvider>().taste_Meals;
    Iterable<Meal> restaurantMeals = context
        .read<TasteProvider>()
        .taste_Meals
        .where((element) => element.restaurantId == restaurant.id);
    return Stack(
      children: [
        Container(
            padding: const EdgeInsets.all(15),
            alignment: Alignment.topLeft,
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(restaurant.imageUrl))),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 40, top: 30),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("YOU CAN REALLY",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                          Text(
                            "TASTE",
                            style: GoogleFonts.tangerine(
                              color: const Color.fromARGB(255, 248, 95, 106),
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(" THE DELIVERY",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white))
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 200),
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                      left: 30, right: 30, top: 30, bottom: 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(15)),
                  height: 70,
                  width: double.infinity,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.info,
                          color: Colors.white,
                        ),
                        const Text(
                          "Complete Your Order",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 800),
                                    transitionsBuilder: (_, a, __, c) =>
                                        FadeTransition(opacity: a, child: c),
                                    pageBuilder: (_, __, ___) => const Material(
                                        child: TasteCartPage())));
                          },
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ),
                        )
                      ]),
                ),
              ]),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 320),
          child: ListView.builder(
              itemCount: restaurantMeals.length,
              itemBuilder: ((context, index) {
                Meal e = restaurantMeals.elementAt(index);
                return InkWell(
                    onTap: () {
                      context.read<TasteProvider>().UpdateSelectedMeal(e);

                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 800),
                              transitionsBuilder: (_, a, __, c) =>
                                  FadeTransition(opacity: a, child: c),
                              pageBuilder: (_, __, ___) => const Material(
                                  child: TasteRestaurantView())));
                    },
                    child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.2, color: Colors.grey),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 3,
                                  offset: Offset(2, 4))
                            ],
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(e.imageUrl)),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                            ),
                            Container(
                              height: 100,
                              margin: const EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 3),
                                        child: Text(
                                          e.title,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 23,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 280,
                                        child: Text(
                                          e.description,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 116, 116, 116),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                e.price.toString(),
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 43, 43, 43),
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const Text(
                                                " JOD ",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 43, 43, 43),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: e.isInCart
                                            ? const Icon(
                                                Icons.remove_circle_rounded,
                                                size: 35,
                                                color: Colors.red,
                                              )
                                            : const Icon(
                                                Icons.add_circle_rounded,
                                                size: 35,
                                                color: Color.fromARGB(
                                                    255, 52, 206, 59),
                                              ),
                                        onPressed: () {
                                          setState(() {
                                            int index = Meals.indexOf(e);

                                            Meals[index].isInCart =
                                                !Meals[index].isInCart;
                                          });
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        )));
              })),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 10,
            top: 40,
          ),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: Theme.of(context).colorScheme.primary,
              )),
        ),
      ],
    );
  }

  Row RightSectionOfEachMeal(bool Value, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(
          Value ? Icons.done : Icons.close,
          color: Value ? Colors.green : Colors.red,
        )
      ],
    );
  }
}
