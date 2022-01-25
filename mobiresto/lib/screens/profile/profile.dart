// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobiresto/constants/colors.dart';
import 'package:mobiresto/models/user_model.dart';
import 'package:mobiresto/screens/home_screen.dart';
import 'package:mobiresto/screens/login_screens.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loginuser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loginuser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: secondaryColor,
        leading: IconButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => homePage())),
          icon: const Icon(
            Icons.arrow_back,
            color: primaryColor,
            size: 20,
          ),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: primaryColor),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 1),
          child: Container(
            height: MediaQuery.of(context).size.height* .3,
        width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 115,
                  width: 115,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/user.png'),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ProfileMenu(
                  icon: Icons.person,
                  text: "Names : ${loginuser.names}",
                  press: () {},
                ),
                ProfileMenu(
                  icon: Icons.email_outlined,
                  text: "Email: ${loginuser.email}",
                  press: () {},
                ),
                ProfileMenu(
                  icon: Icons.phone,
                  text: "Phone number: ${loginuser.phonenumber}",
                  press: () {},
                ),
                ProfileMenu(
                  icon: Icons.location_city,
                  text: "Address : ${loginuser.address}",
                  press: () {},
                ),
                ActionChip(
                    backgroundColor: primaryColor,
                    avatar: const CircleAvatar(
                      child: Icon(Icons.logout, color: secondaryDarkColor,size: 20,),
                      backgroundColor: primaryColor,
                    ),
                    padding: const EdgeInsets.fromLTRB(150, 15, 150, 15),
                    label: Text('Logout',style: TextStyle(fontWeight: FontWeight.bold),),
                    onPressed: () {
                      logout(context);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const loginScreen()));
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: const Color(0xFFF5F6F9),
        onPressed: () {},
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: Colors.orangeAccent,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(child: Text(text))
          ],
        ),
      ),
    );
  }
}
