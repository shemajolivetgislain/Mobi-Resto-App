import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobiresto/constants/colors.dart';
import 'package:mobiresto/screens/mainpage/mainpage.dart';
import 'package:mobiresto/screens/pages/listdish.dart';
import 'package:mobiresto/screens/pages/listrestaurant.dart';
import 'package:mobiresto/screens/profile/profile.dart';


class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {


  final List pages = [
    const MainPage(),
    const RestaurantPage(dishesdetail: ''),
    const Dishes(dishesdetail: '',),
    const ProfilePage(),
  ];

 

  int currentindex = 0;
  void onTap(int index) {
    setState(() {
      currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: pages[currentindex],
      bottomNavigationBar: BottomNavBar(),
    );
  }

  BottomNavigationBar BottomNavBar() {
    return BottomNavigationBar(
      currentIndex: currentindex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 30,
            color: primaryColor,
            
          ),
          title: SizedBox.shrink(),
          
        ),
        
        BottomNavigationBarItem(
          icon: Icon(
            Icons.restaurant_menu_outlined,
            size: 25,
            color: secondaryDarkColor,
          ),
          title: SizedBox.shrink(),
        ),
                BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.hamburger,
            size: 25,
            color: secondaryDarkColor,
          ),
          title: SizedBox.shrink(),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle_outlined,
            size: 30,
            color: secondaryDarkColor,
          ),
          title: SizedBox.shrink(),
        ),
      ],
    );
  }
}
