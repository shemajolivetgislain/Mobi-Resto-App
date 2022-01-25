import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobiresto/constants/colors.dart';
import 'package:mobiresto/models/district.dart';
import 'package:mobiresto/models/restaurant.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:mobiresto/screens/details_pages/resto_details.dart';

class RestaurantLocation extends StatefulWidget {
  final District district;
  const RestaurantLocation({
    required this.district,
  });

  @override
  _RestaurantLocationState createState() => _RestaurantLocationState();
}

class _RestaurantLocationState extends State<RestaurantLocation> {
  Future<List<Restaurants>> fetchDistrictrestaurant(int dis) async {
    var url =
        'http://jolivet-api.azurewebsites.net/districts/$dis/district_restaurant/';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Restaurants.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
  
  late Future<List<Restaurants>> futureRestaurants;
  @override
  void initState() {
    super.initState();
    futureRestaurants = fetchDistrictrestaurant(widget.district.id);
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
                  tag: NetworkImage(widget.district.image),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image(
                      image: NetworkImage(widget.district.image),
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
                    const Text(
                      'Address',
                      style: TextStyle(
                          fontSize: 20,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.3),
                    ),
                    Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.locationArrow,
                          size: 10,
                          color: secondaryColor,
                        ),
                        Text(
                          widget.district.name,
                          style: const TextStyle(
                              fontSize: 10,
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

// ***********restaurant cards design************************

          Expanded(
            child: FutureBuilder<List<Restaurants>>(
              future: futureRestaurants,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Restaurants>? data = snapshot.data;
                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 10.0),
                    itemCount: data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      Restaurants restora = data[index];
                      return Stack(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => RestoDetail(
                                          resto: restora,
                                        ))),
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(
                                  30.0, 5.0, 20.0, 5.0),
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
                                    const EdgeInsets.fromLTRB(190, 20, 20, 20),
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
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: activeColor,
                                            ),
                                            // overflow: TextOverflow.ellipsis,
                                            // maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            'Rating :',
                                            style: TextStyle(
                                                color: accentColor,
                                                fontSize: 12),
                                          ),
                                          Wrap(
                                            children: List.generate(5, (index) {
                                              return Icon(Icons.star,
                                                  size: 15,
                                                  color: index < restora.rating
                                                      ? primaryColor
                                                      : accentColor);
                                            }),
                                          )
                                        ],
                                      ),
                                    ),
                                    Text(
                                      'Owner: ' + data[index].owner,
                                      style: const TextStyle(
                                          color: accentColor, fontSize: 12),
                                    ),
                                    Text(
                                      'Address: ' + data[index].district,
                                      style: const TextStyle(
                                          color: accentColor, fontSize: 12),
                                    ),
                                    // _buildRatingStars(restora.rating),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 40,
                            top: 10,
                            bottom: 10,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image(
                                width: 150,
                                image: NetworkImage(data[index].image),
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
