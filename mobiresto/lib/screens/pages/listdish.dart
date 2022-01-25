import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobiresto/Navigation_Drawer/navigationdrawer.dart';
import 'package:mobiresto/constants/colors.dart';
import 'package:mobiresto/models/dish.dart';
import 'package:mobiresto/screens/details_pages/dish_detail.dart';

class Dishes extends StatefulWidget {
  final String dishesdetail;
  const Dishes({
    Key? key,
    required this.dishesdetail,
  }) : super(key: key);

  @override
  State<Dishes> createState() => _DishesState();
}

class _DishesState extends State<Dishes> {
  Future<List<Dish>> fetchDish() async {
    var url = 'http://jolivet-api.azurewebsites.net/dishes/';
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

  late Future<List<Dish>> futureDishes;
  @override
  void initState() {
    super.initState();
    futureDishes = fetchDish();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      drawer: const NavigatioDrawer(),
      appBar: buildAppBar(),
      body: Column(children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 20.0, right: 60.0, top: 20),
          child: Text(
            'List of Mobi-Resto Dish should afford to you?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
         const SizedBox(height: 10),
        buildDishes(),
      ]),
    );
  }

  Widget buildDishes() => Expanded(
        child: FutureBuilder<List<Dish>>(
          future: futureDishes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Dish>? data = snapshot.data;
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
                        child: Card(
                          elevation: 4,
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                               AspectRatio(
                                  aspectRatio: 18 / 14,
                                  child: Image(
                                    image: NetworkImage(info.pictures[0].image),
                                    fit: BoxFit.cover,
                                  )),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 16.0, 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        info.name,
                                        // style: theme.textTheme.bodyText1,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        info.price,
                                        // style: theme.textTheme.caption,
                                        style: const TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // End new code
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => DishDetail(
                                    dishes: info,
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
