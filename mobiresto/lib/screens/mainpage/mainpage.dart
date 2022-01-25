import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobiresto/Navigation_Drawer/navigationdrawer.dart';
import 'package:mobiresto/constants/colors.dart';
import 'package:mobiresto/screens/home_screen.dart';
import 'package:mobiresto/screens/pages/searchpage/searchpage.dart';
import 'package:mobiresto/screens/widget/exploration.dart';
import 'package:mobiresto/screens/widget/restaurant_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedindex = 0;
  int _currenttab = 0;
  final List<IconData> _icons = [
    Icons.location_on_outlined,
    Icons.restaurant_menu,
    Icons.local_pizza,
    FontAwesomeIcons.hamburger,
  ];
  Widget _buildicon(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedindex = index;
        });
        print(_selectedindex);
      },
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
            color: _selectedindex == index ? primaryDarkColor : primaryColor,
            borderRadius: BorderRadius.circular(30)),
        child: Icon(
          _icons[index],
          size: 25.0,
          color: _selectedindex == index ? activeColor : secondaryColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
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
            onPressed: () {
              showSearch(context: context, delegate: customSearchDelegate());
            },
            icon: const Icon(
              Icons.search_sharp,
              color: primaryColor,
              size: 30,
            ),
          ),
        ],
      ),
      drawer: const NavigatioDrawer(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                'What would You Like to Find?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _icons
                  .asMap()
                  .entries
                  .map(
                    (MapEntry map) => _buildicon(map.key),
                  )
                  .toList(),
            ),
            const SizedBox(
              height: 10,
            ),
            const locationExplore(),
            const SizedBox(
              height: 10,
            ),
            const RestaurantExplore()
          ],
        ),
      ),
    );
  }
}
