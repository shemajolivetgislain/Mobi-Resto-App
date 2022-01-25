class Dish {
  int id;
  String name;
  String cookingTime;
  List<String> ingredient;
  String price;
  String restaurant;
  String cuisine;
  List<Pictures> pictures;

  Dish({
    required this.id,
    required this.name,
    required this.cookingTime,
    required this.ingredient,
    required this.price,
    required this.restaurant,
    required this.cuisine,
    required this.pictures,
  });
  factory Dish.fromJson(Map<String, dynamic> json) {
    var list = json['pictures'] as List;
    List<Pictures> picList = list.map((pictures) => Pictures.fromJson(pictures)).toList();
    return Dish(
      id: json['id'],
      name: json['name'],
      cookingTime: json['cookingTime'],
      ingredient: json['ingredient'].cast<String>(),
      price: json['price'],
      restaurant: json['restaurant'],
      cuisine: json['cuisine'],
      pictures: picList
    );
  }
}

class Pictures {
  int id;
  int dish;
  String name;
  String image;

  Pictures({required this.id, required this.dish, required this.name, required this.image});

  factory Pictures.fromJson(Map<String, dynamic> json) {
    return Pictures(
      id: json['id'],
      dish: json['dish'],
      name: json['name'],
      image: json['image'],
    );
  }
}

// class Dish {
//   String imageUrl;
//   String name;
//   String cookingtime;
//   String ingredients;
//   String cuisine;
//   String restaurant;
//   int price;

//   Dish({
//     required this.imageUrl,
//     required this.name,
//     required this.cookingtime,
//     required this.ingredients,
//     required this.cuisine,
//     required this.restaurant,
//     required this.price,
//   });
// }