import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobiresto/constants/colors.dart';
import 'package:mobiresto/models/district.dart';
import 'package:mobiresto/screens/locationresto.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:mobiresto/screens/pages/listrestaurant.dart';

class locationExplore extends StatefulWidget {
  const locationExplore({Key? key}) : super(key: key);

  @override
  State<locationExplore> createState() => _locationExploreState();
}

class _locationExploreState extends State<locationExplore> {
  // Future fetchdistrict() async {
  //   var url = 'http://jolivet-api.azurewebsites.net/districts/';
  //   var response = await http.get(Uri.parse(url));
  //   var jsondata = jsonDecode(response.body);

  //   List<District> districts = [];
  //   for (var u in jsondata) {
  //     District district = District(id: u["id"], name: u["name"]);
  //     districts.add(district);
  //   }
  //   print(districts.length);
  //   return districts;
  // }

  // @override
  // void initState() {
  //   super.initState();
  // }

  Future<List<District>> fetchDistrict() async {
    var url = 'http://jolivet-api.azurewebsites.net/districts/';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => District.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  late Future<List<District>> futureDistrict;
  @override
  void initState() {
    super.initState();
    futureDistrict = fetchDistrict();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Explore By Location',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RestaurantPage(dishesdetail: '',)),
                    ),
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
          child: FutureBuilder<List<District>>(
            future: futureDistrict,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<District>? data = snapshot.data;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    District districts = data[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RestaurantLocation(
                            district: districts,
                          ),
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(15),
                        width: 220,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Positioned(
                              bottom: 15.0,
                              child: Container(
                                width: 200,
                                height: 120,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children:  [
                                      // Text(
                                      //   "10 Restaurants",
                                      //   style: TextStyle(
                                      //       fontWeight: FontWeight.w700,
                                      //       fontSize: 18,
                                      //       letterSpacing: 1.2),
                                      // ),
                                      Text(
                                        "Tap here to get ${data[index].name} Restaurants",
                                        style: TextStyle(color: accentColor,fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
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
                                  Hero(
                                    tag: NetworkImage(data[index].image),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image(
                                        height: 200,
                                        width: 180.0,
                                        image: NetworkImage(data[index].image),
                                        fit: BoxFit.cover,
                                      ),
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
                                          'Address',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: secondaryColor,
                                              fontWeight: FontWeight.w600,
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
                                              data[index].name,
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
              return const Center(child: LinearProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}
