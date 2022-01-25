import 'package:flutter/material.dart';
import 'package:mobiresto/constants/colors.dart';
import 'package:mobiresto/models/restaurant.dart';
import 'package:mobiresto/screens/home_screen.dart';

class RestoDetail extends StatefulWidget {
   final dynamic resto;
  const RestoDetail({Key? key, this.resto}) : super(key: key);

  @override
  _RestoDetailState createState() => _RestoDetailState();
}

class _RestoDetailState extends State<RestoDetail> {
   Restaurants get resto => widget.resto;
  @override
  Widget build(BuildContext context) {
   final gottenstars =resto.rating;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 400,
            decoration:  BoxDecoration(
              image: DecorationImage(
                image:  NetworkImage(resto.image),
                fit: BoxFit.cover,
              ),
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
                  decoration: BoxDecoration(color: secondaryColor, boxShadow: [
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
          // center container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .6,
              decoration: const BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: secondaryDarkColor,
                      offset: Offset(0, -4),
                      blurRadius: 8,
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 60,
                      height: 5,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  )),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Row(
                      children: [
                         Expanded(
                          child: Text(
                            resto.name,
                            style: TextStyle(
                                color: secondaryDarkColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Wrap(
                                          children: List.generate(5, (index) {
                                            return Icon(Icons.star,
                                                size: 15,
                                                color:
                                                    index< gottenstars
                                                        ? primaryColor
                                                        : accentColor);
                                          }),
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 14, right: 20),
                    child: Row(
                      children:  [
                        Icon(
                          Icons.location_on_outlined,
                          color: primaryColor,
                        ),
                        Text(
                          resto.district,
                          style: TextStyle(
                            color: accentColor,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                          const  Icon(
                              Icons.phone,
                              size: 20,
                              color: primaryColor,
                            ),
                           const SizedBox(
                              width: 5,
                            ),
                           const Text(
                              'Contact Us:',
                              style: TextStyle(
                                  color: secondaryDarkColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                           const SizedBox(
                              width: 20,
                            ),
                            Text(
                              resto.contact,
                              style: TextStyle(
                                color: accentColor,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Owner:',
                          style: TextStyle(
                              color: secondaryDarkColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                         Text(
                          resto.owner,
                          style: TextStyle(
                            color: accentColor,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Description',
                          style: TextStyle(
                              color: secondaryDarkColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          resto.description,
                          style: const TextStyle(
                            color: accentColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height:  MediaQuery.of(context).size.height* .1,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: accentColor.withOpacity(0.7),
                          offset: Offset(0, -1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 20,0 , 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                               const Text(
                                  'Price-Range',
                                  style: TextStyle(
                                      color: secondaryDarkColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  resto.pricerange,
                                  style: TextStyle(
                                    color: accentColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => homePage())),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 50),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: const [
                                Text(
                                  'Back To Home ',
                                  style: TextStyle(
                                      color: secondaryDarkColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
