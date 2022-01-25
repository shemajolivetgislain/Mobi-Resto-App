import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobiresto/constants/colors.dart';
import 'package:mobiresto/models/restaurant.dart';
import 'package:mobiresto/screens/pages/listdish.dart';
import 'package:mobiresto/screens/restaurantdish.dart';
import 'package:http/http.dart' as http;

class RestaurantExplore extends StatefulWidget {
  const RestaurantExplore({
    Key? key,
  }) : super(key: key);

  @override
  State<RestaurantExplore> createState() => _RestaurantExploreState();
}

class _RestaurantExploreState extends State<RestaurantExplore> {
  Future<List<Restaurants>> fetchRestaurant() async {
    var url = 'https://jolivet-api.azurewebsites.net/restaurants/';
    var response = await http.get(
      Uri.parse(url), // Send authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader:
            'Token 60315c5afab6dc496dc460072deeab27dd5b1729',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Restaurants.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  late Future<List<Restaurants>> futureRestaurant;
  @override
  void initState() {
    super.initState();
    futureRestaurant = fetchRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Exclusive Restaurants',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const Dishes(dishesdetail: '',))),
              child: const Text(
                'See All',
                style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
            )
          ],
        ),
      ),
      Container(
        height: 300,
        child: FutureBuilder<List<Restaurants>>(
          future: futureRestaurant,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Restaurants>? data = snapshot.data;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  Restaurants infoRestauration = data[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => RestaurantDish(
                                restaurantdish: infoRestauration,
                              )),
                    ),
                    // CONTAINER WHICH HOLD SAMPLE DETAILS
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: 300,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Positioned(
                            bottom: 40.0,
                            // CONTAINER WHICH HOLD SAMPLE DETAILS
                            child: Container(
                              width: 280,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0.0, 0.2),
                                      blurRadius: 6.0)
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                      const  Text(
                                          "Price Range  ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12,
                                              letterSpacing: 1.2,
                                              color: primaryColor),
                                        ),
                                                                                Text(
                                          data[index].pricerange,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12,
                                              letterSpacing: 1.2,
                                              color: primaryColor),
                                        ),
                                        const SizedBox(
                                          width: 55,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      data[index].district + '-'+ data[index].sector ,
                                      style:
                                          const TextStyle(color: accentColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // container of picture with internal text that overide other container
                          Container(
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0.0, 0.2),
                                    blurRadius: 6.0)
                              ],
                            ),
                            child: Stack(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image(
                                    height: 200,
                                    width: 280.0,
                                    image: NetworkImage(data[index].image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  left: 10.0,
                                  bottom: 10.0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Text(
                                        'Restaurant',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: secondaryColor,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1.3),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.restaurant,
                                            size: 10,
                                            color: secondaryColor,
                                          ),
                                          Text(
                                            data[index].name,
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: secondaryColor,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1.3),
                                          ),
                                          SizedBox(width: 20,),
                                          // ***********stars ratings**************//
                                          Wrap(
                                            children: List.generate(5, (index) {
                                              return Icon(Icons.star,
                                                  size: 20,
                                                  color: index <=
                                                          infoRestauration
                                                              .rating
                                                      ? primaryColor
                                                      : accentColor);
                                            }),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default show a loading spinner.
            return const LinearProgressIndicator(
              backgroundColor: Colors.transparent,
              color: Colors.transparent,
            );
          },
        ),
      ),
    ]);
  }
}
