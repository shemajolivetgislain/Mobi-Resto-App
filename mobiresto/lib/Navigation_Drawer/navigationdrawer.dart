import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobiresto/constants/colors.dart';
import 'package:mobiresto/models/dish.dart';
import 'package:mobiresto/screens/home_screen.dart';
import 'package:mobiresto/screens/login_screens.dart';
import 'package:mobiresto/screens/pages/listdish.dart';
import 'package:mobiresto/screens/pages/listrestaurant.dart';
import 'package:mobiresto/screens/profile/profile.dart';
import 'drawer_item.dart';

class NavigatioDrawer extends StatelessWidget {
  const NavigatioDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: secondaryColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 80, 24, 0),
          child: Column(
            children: [
              headerwidget(),
              const Divider(
                thickness: 1,
                color: primaryColor,
              ),
              const SizedBox(
                height: 5,
              ),
              DrawerItem(
                names: 'Home',
                icon: Icons.home,
                onPressed: () => onItemPressed(context, index: 0),
              ),
              const SizedBox(height: 20),
              DrawerItem(
                names: 'Restaurants',
                icon: Icons.restaurant_outlined,
                onPressed: () => onItemPressed(context, index: 1),
              ),
              const SizedBox(height: 20),
              DrawerItem(
                names: 'Dishes',
                icon: FontAwesomeIcons.hamburger,
                onPressed: () => onItemPressed(context, index: 2),
              ),
              const SizedBox(height: 20),
              DrawerItem(
                names: 'Profile',
                icon: Icons.person,
                onPressed: () => onItemPressed(context, index: 3),
              ),
              const SizedBox(height: 30),
              DrawerItem(
                names: 'Logout',
                icon: Icons.logout_outlined,
                onPressed: () => onItemPressed(context, index: 3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);

    switch (index) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const homePage(),
            ));

        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RestaurantPage(
                dishesdetail: '',
              ),
            ));
        break;
      case 2:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Dishes(
                dishesdetail: '',
              ),
            ));
        break;
      case 3:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfilePage(),
            ));
        break;
      case 4:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const loginScreen()
              
            ));
        break;
    }
  }

  Widget headerwidget() {
    return Column(
      children: [
        Image(image: AssetImage('images/logo.png')),
      ],
    );
  }
}
