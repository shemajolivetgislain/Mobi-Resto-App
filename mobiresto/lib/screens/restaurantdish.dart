import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobiresto/constants/colors.dart';
import 'package:mobiresto/models/dish.dart';
import 'package:mobiresto/models/restaurant.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:mobiresto/screens/details_pages/dish_detail.dart';

class RestaurantDish extends StatefulWidget {
  final Restaurants restaurantdish;
  RestaurantDish({required this.restaurantdish});

  @override
  _RestaurantDishState createState() => _RestaurantDishState();
}

class _RestaurantDishState extends State<RestaurantDish> {
  Future<List<Dish>> fetchRestoDish(restor) async {
    var url =
        'http://jolivet-api.azurewebsites.net/restaurants/$restor/dishes_restaurant/';
    var response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader:
            'Token 60315c5afab6dc496dc460072deeab27dd5b1729',
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Dish.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  late Future<List<Dish>> futureDisheresto;
  @override
  void initState() {
    super.initState();
    futureDisheresto = fetchRestoDish(widget.restaurantdish.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2.0),
                    ),
                  ],
                ),
                child: Hero(
                  tag: NetworkImage(widget.restaurantdish.image),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image(
                      image: NetworkImage(widget.restaurantdish.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                      iconSize: 30.0,
                      color: secondaryDarkColor,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(
                            Icons.search,
                          ),
                          iconSize: 30.0,
                          color: secondaryDarkColor,
                          onPressed: () => Navigator.pop(context),
                        ),
                        IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.sortAmountDown,
                          ),
                          iconSize: 30.0,
                          color: secondaryDarkColor,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 20.0,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Restaurant',
                      style: TextStyle(
                          fontSize: 20,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.3),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.restaurant,
                          size: 20,
                          color: secondaryColor,
                        ),
                        Text(
                          widget.restaurantdish.name,
                          style: const TextStyle(
                              fontSize: 15,
                              color: secondaryColor,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.3),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Positioned(
                  right: 20,
                  bottom: 20,
                  child: Icon(
                    Icons.location_on,
                    color: primaryColor,
                    size: 30.0,
                  ))
            ],
          ),

// ***********Dishcards design************************

          Expanded(
            child: FutureBuilder<List<Dish>>(
              future: futureDisheresto,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Dish>? data = snapshot.data;
                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 10.0),
                    itemCount: data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      Dish dish = data[index];
                      return Stack(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DishDetail(
                                          dishes: dish,
                                        ))),
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(
                                  10.0, 5.0, 20.0, 5.0),
                              height: 140.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: secondaryColor,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: accentColor,
                                    blurRadius: 6.0,
                                    offset: Offset(0, 5.0),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(160, 10, 20, 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: 150,
                                          child: Text(
                                            data[index].name,
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: activeColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_right_sharp,
                                          size: 30,
                                          color: primaryColor,
                                        )
                                      ],
                                    ),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          const Text(
                                            'Price    ',
                                            style: TextStyle(
                                                color: accentColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            height: 20,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: primaryDarkColor),
                                            child: Center(
                                              child: Text(
                                                dish.price,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            secondaryDarkColor,
                                                        fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Cooking Time: ',
                                          style: TextStyle(
                                              color: accentColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Container(
                                            height: 20,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: buttonColor),
                                            child: Center(
                                              child: Text(
                                                dish.cookingTime,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            secondaryDarkColor,
                                                        fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Cuisine: ' + data[index].cuisine,
                                      style: const TextStyle(
                                          color: accentColor, fontSize: 15),
                                    ),
                                    // _buildRatingStars(restora.rating),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 11,
                            top: 10,
                            bottom: 10,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image(
                                width: 150,
                                image: NetworkImage(dish.pictures[0].image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
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
        ],
      ),
    );
  }
}
