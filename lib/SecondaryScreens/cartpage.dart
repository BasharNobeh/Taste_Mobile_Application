import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taste_application/models/restaurant.dart';

import '../models/Meal.dart';
import '../provider_files/taste_provider.dart';

class TasteCartPage extends StatefulWidget {
  const TasteCartPage({super.key});

  @override
  State<TasteCartPage> createState() => _TasteCartPageState();
}

class _TasteCartPageState extends State<TasteCartPage> {
  Icon heartIcon = const Icon(Icons.favorite_border_outlined);
  @override
  Widget build(BuildContext context) {
    List<Meal> Meals = context.watch<TasteProvider>().taste_Meals;
    List<Restaurant> restaurants =
        context.watch<TasteProvider>().edited_Taste_resturants;
    Iterable<Meal> cartMeals = context.watch<TasteProvider>().GetCartItems();

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 70, bottom: 50),
          child: cartMeals.isEmpty
              ? Center(
                  child: Text(
                    "Add Some Meals To Your Cart !",
                    style: GoogleFonts.roboto(
                      color: const Color.fromARGB(255, 36, 36, 36),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: cartMeals.length,
                  itemBuilder: ((context, index) {
                    Meal e = cartMeals.toList()[index];
                    return InkWell(
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.2, color: Colors.grey),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 3,
                                      offset: Offset(2, 4))
                                ],
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(20)),
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
                                            color: Color.fromARGB(
                                                255, 161, 158, 158),
                                            blurRadius: 3)
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(e.imageUrl))),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 140,
                                      child: Text(
                                        e.title,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: Text(e.description),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${e.price.toString()} JOD",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    )
                                  ],
                                ),
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
                                          color:
                                              Color.fromARGB(255, 52, 206, 59),
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
        Align(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 80),
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(0, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(
                        left: 10, right: 10, top: 30, bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15)),
                    height: 50,
                    width: double.infinity,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(40, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(10)),
                                width: 35,
                                height: 35,
                                margin: const EdgeInsets.only(left: 20),
                                child: Center(
                                    child: Text(
                                  cartMeals.length.toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Check out",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Container(
                              margin: const EdgeInsets.only(right: 20),
                              child: Text(
                                "${context.watch<TasteProvider>().GetCartTotal().toStringAsFixed(2)} JOD ",
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              )),
                        ]),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
