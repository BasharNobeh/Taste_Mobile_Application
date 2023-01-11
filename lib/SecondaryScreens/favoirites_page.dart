import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taste_application/SecondaryScreens/restaurant_view.dart';
import 'package:taste_application/models/restaurant.dart';

import '../provider_files/taste_provider.dart';

class TasteFavoritesPage extends StatefulWidget {
  const TasteFavoritesPage({super.key});

  @override
  State<TasteFavoritesPage> createState() => _TasteFavoritesPageState();
}

class _TasteFavoritesPageState extends State<TasteFavoritesPage> {
  Icon heartIcon = const Icon(Icons.favorite_border_outlined);
  @override
  Widget build(BuildContext context) {
    List<Restaurant> restaurants =
        context.watch<TasteProvider>().edited_Taste_resturants;

    Iterable favrestaurant =
        context.watch<TasteProvider>().GetFavoriteRestaurants();
    return Stack(
      children: [
        Container(
            margin: const EdgeInsets.only(
              top: 20,
            ),
            child: favrestaurant.isEmpty
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white24,
                    child: Center(
                      child: Text(
                        "Add Some Restaurants To Your Favorites !",
                        style: GoogleFonts.roboto(
                          color: const Color.fromARGB(255, 36, 36, 36),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: favrestaurant.length,
                    itemBuilder: ((context, index) {
                      Restaurant e = favrestaurant.toList()[index];

                      return InkWell(
                          onTap: () {
                            context
                                .read<TasteProvider>()
                                .UpdateSelectedRestaurant(e);

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
                                  border: Border.all(
                                      width: 0.2, color: Colors.grey),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 3,
                                        offset: Offset(2, 4))
                                  ],
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20))),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    height: 100,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(e.imageUrl)),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        )),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 65,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 3),
                                          child: Text(
                                            e.title,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                int index =
                                                    restaurants.indexOf(e);

                                                restaurants[index].isFavorite =
                                                    !restaurants[index]
                                                        .isFavorite;
                                              });
                                            },
                                            icon: e.isFavorite
                                                ? const Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                  )
                                                : const Icon(
                                                    Icons
                                                        .favorite_outline_outlined,
                                                    color: Colors.red,
                                                  )),
                                      ],
                                    ),
                                  ),
                                ],
                              )));
                    })))
      ],
    );
  }
}
