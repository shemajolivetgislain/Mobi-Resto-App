class UserModel {
  String? uid;
  String? names;
  String? email;
  String? phonenumber;
  String? address;

  UserModel({this.uid, this.names,this.email, this.phonenumber, this.address});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      names: map['names'],
      email: map['email'],
      phonenumber: map['phonenumber'],
      address: map['address'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'names': names,
      'email': email,
      'phonenumber': phonenumber,
      'address': address,
    };
  }
}