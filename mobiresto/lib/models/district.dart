
class District {
  final int id;
  final String name;
  final String image;

  District({
    required this.id,
    required this.name,
    required this.image,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}


















// List<Restaurants> restaurant = [
//   Restaurants(
//     imageUrl: 'images/1.jpeg',
//     name: 'Serena',
//     rating: 4,
//     district: 'Gasabo',
//     owner: 'Company',
//     dish: dishes,
//   ),
//   Restaurants(
//     imageUrl: 'images/4.jpeg',
//     name: 'Ubumwe',
//     rating: 4,
//     district: 'Nyarugenge',
//     owner: 'Company',
//     dish: dishes,
//   ),
//   Restaurants(
//     imageUrl: 'images/5.jpg',
//     name: 'Ishema',
//     rating: 4,
//     district: 'Kicukiro',
//     owner: 'Individual',
//     dish: dishes,
//   ),
//   Restaurants(
//     imageUrl: 'images/11.jpeg',
//     name: 'Serena',
//     rating: 4,
//     district: 'Gasabo',
//     owner: 'Company',
//     dish: dishes,
//   ),
// ];











// // List<District> district = [
// //   District(
// //     imageUrl: 'images/location/6.jpg',
// //     name: 'Gasabo',
// //     resto: restaurant,
// //   ),
// //   District(
// //     imageUrl: 'images/location/4.jpg',
// //     name: 'Nyarugenge',
// //     resto: restaurant,
// //   ),
// //   District(
// //     imageUrl: 'images/location/2.jpg',
// //     name: 'Kicukiro',
// //     resto: restaurant,
// //   ),
// //   District(
// //     imageUrl: 'images/location/6.jpg',
// //     name: 'Rubavu',
// //     resto: restaurant,
// //   ),
// //   District(
// //     imageUrl: 'images/1.jpeg',
// //     name: 'Rubavu',
// //     resto: restaurant,
// //   ),
// // ];
