import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobiresto/constants/colors.dart';
import 'package:mobiresto/models/user_model.dart';
import 'package:mobiresto/screens/home_screen.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
// editing

  final TextEditingController namesEditingcontroller = TextEditingController();
  final TextEditingController emailEditingcontroller = TextEditingController();
  final TextEditingController telephoneEditingcontroller =
      TextEditingController();
  final TextEditingController addressEditingcontroller =
      TextEditingController();
  final TextEditingController passwordEditingcontroller =
      TextEditingController();
  final TextEditingController confirmpasswordEditingcontroller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final namesfield = TextFormField(
      autofocus: false,
      controller: namesEditingcontroller,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Names cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid name(Min. 3 Character)");
        }
        return null;
      },
      onSaved: (value) {
        namesEditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Names",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
    );
    final emailfield = TextFormField(
      autofocus: false,
      controller: emailEditingcontroller,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailEditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
    );
    final phonefield = TextFormField(
      autofocus: false,
      controller: telephoneEditingcontroller,
      keyboardType: TextInputType.number,
      validator: (value) {
        RegExp regex = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
        if (value!.isEmpty) {
          return ("please your phone number");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid phoneNumber(Min. 10 Character)");
        }
        return null;
      },
      onSaved: (value) {
        telephoneEditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.phone),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "phone number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
    );
    final addressfield = TextFormField(
      autofocus: false,
      controller: addressEditingcontroller,
      keyboardType: TextInputType.name,

      //validator
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Address cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid name(Min. 3 Character)");
        }
        return null;
      },
      onSaved: (value) {
        addressEditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.location_city),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "address",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
    );
    final passwordfield = TextFormField(
      autofocus: false,
      controller: passwordEditingcontroller,
      obscureText: true,

      //validator

      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
      },
      onSaved: (value) {
        passwordEditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
    );
    final confirmPassowrdfield = TextFormField(
      autofocus: false,
      controller: confirmpasswordEditingcontroller,
      obscureText: true,

      //validator
      validator: (value) {
        if (confirmpasswordEditingcontroller.text !=
            passwordEditingcontroller.text) {
          return "Password don't match";
        }
        return null;
      },

      onSaved: (value) {
        confirmpasswordEditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "confirm password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
    );

    final signupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      color: buttonColor,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailEditingcontroller.text, passwordEditingcontroller.text);
        },
        child: const Text(
          "SignUp",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: textColor, fontSize: 19, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          Positioned(
            top: -15,
            right: 0,
            left: 0,
            child: Container(
              height: MediaQuery.of(context).size.height* .5,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                  bottomLeft: Radius.circular(80),
                ),
                image: DecorationImage(
                    image: AssetImage(
                      "images/1.jpeg",
                    ),
                    fit: BoxFit.cover),
              ),
              child: Container(
                padding: const EdgeInsets.only(top: 15, left: 20),
                color: primaryColor.withOpacity(.65),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 250,
                      child: const Image(
                        image: AssetImage('images/logo.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 140,
            bottom: 20,
            child: Container(
                height: MediaQuery.of(context).size.height* .8,
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width - 60,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: secondaryDarkColor.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 10,
                      )
                    ]),
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: SizedBox(
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        'SignUp',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              namesfield,
                              const SizedBox(
                                height: 20,
                              ),
                              emailfield,
                              const SizedBox(
                                height: 20,
                              ),
                              phonefield,
                              const SizedBox(
                                height: 20,
                              ),
                              addressfield,
                              const SizedBox(
                                height: 20,
                              ),
                              passwordfield,
                              const SizedBox(
                                height: 20,
                              ),
                              confirmPassowrdfield,
                              const SizedBox(
                                height: 20,
                              ),
                              signupButton,
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          )),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.names = namesEditingcontroller.text;
    userModel.phonenumber = telephoneEditingcontroller.text;
    userModel.address = addressEditingcontroller.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "account created successful :)");
    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => homePage()), (route) => false);
  }
}
