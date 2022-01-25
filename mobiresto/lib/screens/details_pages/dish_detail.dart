// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mobiresto/constants/colors.dart';
import 'package:mobiresto/models/dish.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DishDetail extends StatefulWidget {
  final dynamic dishes;
  DishDetail({Key? key, this.dishes}) : super(key: key);

  @override
  _DishDetailState createState() => _DishDetailState();
}

class _DishDetailState extends State<DishDetail> {
  int activeIndex = 0;
  Dish get dishes => widget.dishes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
            Container(
              // width: MediaQuery.of(context).size.width,
               height: MediaQuery.of(context).size.height* .4,
              // decoration:  BoxDecoration(

              // ),
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  height: 350,
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  pageSnapping: false,
                  onPageChanged: (index, reason) =>
                      setState(() => activeIndex = index),
                ),
                itemCount: dishes.pictures.length,
                itemBuilder: (context, index, realindex) {
                  final dish = dishes.pictures[index];
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    color: secondaryColor,
                    child: Image(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      image: NetworkImage(dish.image),
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            //arrow button
            Positioned(
              top: 50,
              left: 20,
              child: ClipOval(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration:
                        BoxDecoration(color: secondaryColor, boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.7),
                        offset: Offset(0, 4),
                        blurRadius: 8,
                      )
                    ]),
                    child: Center(
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 35,
                left: 150,
                child: Center(
                  child: AnimatedSmoothIndicator(
                    activeIndex: activeIndex,
                    count: dishes.pictures.length,
                    effect: JumpingDotEffect(
                      dotWidth: 15,
                      dotHeight: 15,
                      activeDotColor: primaryColor,
                    ),
                  ),
                )),
          ]),

          // *********************center container)****************************************

          Container(
            // margin: MediaQuery.of(context).padding.,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/ 1.7,
            decoration: const BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: accentColor,
                    offset: Offset(0, -4),
                    blurRadius: 8,
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Details',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                        ),
                        Text(
                          dishes.name,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: accentColor),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                       height: MediaQuery.of(context).size.height*  .4/2 ,
                        decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: accentColor,
                                offset: Offset(0, -4),
                                blurRadius: 8,
                              )
                            ]),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 30, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Price',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: accentColor,
                                            fontSize: 16),
                                  ),
                                  Text(
                                    'RWF ' + dishes.price,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            
                                            fontSize: 14,
                                            color: primaryColor),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 30, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Cooking-Time',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: accentColor,
                                            fontSize: 16),
                                  ),
                                  Container(
      
                                    height: 25,
                                    width:80,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: primaryColor),
                                    child: Center(
                                      child: Text(
                                        dishes.cookingTime,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: secondaryDarkColor,
                                                fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 2,
                              indent: 20,
                              endIndent: 20,
                              color: accentColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 30, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Restaurant',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: accentColor,
                                            fontSize: 16),
                                  ),
                                  Text(
                                    dishes.restaurant,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            color: primaryColor,
                                            fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 30, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Cuisine',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: accentColor,
                                            fontSize: 16),
                                  ),
                                  Text(
                                    dishes.cuisine,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            
                                            color: primaryColor,
                                            fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: const Text(
                      'Ingredients',
                      style: TextStyle(
                          color: secondaryDarkColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Ingredients(dish: dishes),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Ingredients extends StatelessWidget {
  const Ingredients({
    Key? key,
    required this.dish,
  }) : super(key: key);

  final Dish dish;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var item in dish.ingredient)
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*  .1 /3 ,
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: accentColor,
                            offset: Offset(0, -1),
                            blurRadius: 8,
                          )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: accentColor,
                              )),
                          Icon(
                            Icons.add,
                            color: primaryColor,
                          ),
                        ],
                      ),
                    )),
              )
          ],
        ));
  }
}
