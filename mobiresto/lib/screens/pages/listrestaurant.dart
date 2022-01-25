import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobiresto/Navigation_Drawer/navigationdrawer.dart';
import 'package:mobiresto/constants/colors.dart';
import 'package:mobiresto/models/restaurant.dart';
import 'package:mobiresto/screens/details_pages/resto_details.dart';

class RestaurantPage extends StatefulWidget {
  final String dishesdetail;
  const RestaurantPage({
    Key? key,
    required this.dishesdetail,
  }) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  Future<List<Restaurants>> fetchrestaurant() async {
    var url = 'http://jolivet-api.azurewebsites.net/restaurants/';
    var response = await http.get(
      Uri.parse(url),
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

  late Future<List<Restaurants>> futurerestaurants;
  @override
  void initState() {
    super.initState();
    futurerestaurants = fetchrestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      drawer: const NavigatioDrawer(),
      appBar: buildAppBar(),
      body: Column(children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 20.0, right: 50.0, top: 10),
          child: Text(
            'List of Mobi-Resto Restaurants should afford to you?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
         const SizedBox(height: 10),
        buildDishes(),
      ]),
    );
  }

  Widget buildDishes() => Expanded(
        child: FutureBuilder<List<Restaurants>>(
          future: futurerestaurants,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Restaurants>? data = snapshot.data;
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final info = snapshot.data![index];
                    return InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          margin: const EdgeInsets.all(1),
                          width: 120,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              Positioned(
                                bottom: 15.0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width/ 2,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(0.0, 0.2),
                                          blurRadius: 6.0)
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 17, 0, 0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          info.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Wrap(
                                          children: List.generate(5, (index) {
                                            return Icon(Icons.star,
                                                size: 15,
                                                color:
                                                    index.bitLength < info.rating
                                                        ? primaryColor
                                                        : accentColor);
                                          }),
                                        ),
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
                                      tag: NetworkImage(info.image),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image(
                                          height: MediaQuery.of(context).size.height* .2,
                                          width: MediaQuery.of(context).size.width -20,
                                          image:
                                              NetworkImage(data[index].image),
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
                                                Icons.location_on_outlined,
                                                size: 10,
                                                color: secondaryColor,
                                              ),
                                              Text(
                                                info.district,
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: secondaryColor,
                                                    fontWeight: FontWeight.bold,
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
                      ),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => RestoDetail(
                                    resto: info,
                                  ))),
                    );
                  });
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }

            // By default, show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          },
        ),
      );

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: secondaryColor,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(
            Icons.menu_rounded,
            color: primaryColor,
            size: 30,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Center(
        child: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.bold, color: secondaryDarkColor),
            children: const [
              TextSpan(text: 'Mobi'),
              TextSpan(
                text: '-Resto',
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search_sharp,
            color: primaryColor,
            size: 30,
          ),
        ),
      ],
    );
  }
}
