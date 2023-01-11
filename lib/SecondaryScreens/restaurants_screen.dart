import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taste_application/SecondaryScreens/restaurant_view.dart';
import 'package:taste_application/models/restaurant.dart';

import '../provider_files/taste_provider.dart';
import 'cartpage.dart';

class TasteRestaurantsPage extends StatefulWidget {
  const TasteRestaurantsPage({super.key});

  @override
  State<TasteRestaurantsPage> createState() => _TasteRestaurantsPageState();
}

class _TasteRestaurantsPageState extends State<TasteRestaurantsPage> {
  Icon heartIcon = const Icon(Icons.favorite_border_outlined);
  @override
  Widget build(BuildContext context) {
    List<Restaurant> restaurants =
        context.watch<TasteProvider>().edited_Taste_resturants;
    String title = context.watch<TasteProvider>().resturant_page_title;
    return Stack(
      children: [
        Container(
            padding: const EdgeInsets.all(15),
            alignment: Alignment.topLeft,
            width: double.infinity,
            height: 220,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        "Images/Restaurants_pics/RestPageImage.jpg"))),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 30, top: 30),
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
              itemCount: restaurants.length,
              itemBuilder: ((context, index) {
                Restaurant e = restaurants[index];
                return InkWell(
                    onTap: () {
                      context.read<TasteProvider>().UpdateSelectedRestaurant(e);

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
                        padding: const EdgeInsets.all(10),
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
                            borderRadius: BorderRadius.circular(20)),
                        height: 120,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(2, 2),
                                        color:
                                            Color.fromARGB(255, 161, 158, 158),
                                        blurRadius: 3)
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(e.imageUrl))),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.title,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(e.restaurantType.name),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on),
                                        Text(e.location)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.star),
                                        Text(e.rate.toString())
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        int index = restaurants.indexOf(e);

                                        restaurants[index].isFavorite =
                                            !restaurants[index].isFavorite;
                                      });
                                    },
                                    icon: e.isFavorite
                                        ? const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )
                                        : const Icon(
                                            Icons.favorite_outline_outlined,
                                            color: Colors.red,
                                          )),
                              ],
                            )
                          ],
                        )));
              })),
        ),
        title == "Restaurants"
            ? Container()
            : Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.only(right: 20, top: 40),
                  child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
      ],
    );
  }
}
