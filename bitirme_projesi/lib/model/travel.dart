import 'package:flutter/material.dart';

class Travel {
  String name;
  String location;
  String image;
  IconData icon;
  String rate;
  String type;
  String descp;
  String price;

  Travel(
      {required this.image,
      required this.name,
      required this.rate,
      required this.icon,
      required this.location,
      required this.type,
      required this.descp,
      required this.price});

  static fromJson(jsonDecode) {}
}

String text = "";
List<Travel> travel = [
  Travel(
    image: 'images/mosque.jpg',
    name: 'II. Hasan Mosque',
    rate: "4.9",
    icon: Icons.flag,
    location: 'Fas',
    type: 'History',
    descp:
        'Açıklama gelmesi gerekiyor bu kısıma.Açıklama gelmesi gerekiyor bu kısıma.Açıklama gelmesi gerekiyor bu kısıma.',
    price: '\$ 410',
  ),
  Travel(
    image: 'images/turk_caicos_ada.jpg',
    name: 'Grace Bay',
    rate: "5",
    icon: Icons.flag,
    location: 'Turks and Caicos Island',
    type: 'Beach',
    descp: 'Açıklama gelmesi gerekiyor bu kısıma.',
    price: '\$ 340',
  ),
  Travel(
    image: 'images/lhasa.jpg',
    name: 'LHasa',
    rate: "4.7",
    icon: Icons.flag,
    location: 'China',
    type: 'Camp',
    descp: 'Açıklama gelmesi gerekiyor bu kısıma.',
    price: '\$ 510',
  ),
  Travel(
    image: 'images/yerebatan-sarnici2.jpg',
    name: 'Yerebatan Sarnıcı',
    rate: "4.5",
    icon: Icons.flag,
    location: 'Türkiye',
    type: 'History',
    descp: 'Açıklama gelmesi gerekiyor bu kısıma.',
    price: '\$ 560',
  ),
  Travel(
    image: 'images/rocky.jpg',
    name: 'Rocky Dağları',
    rate: "4.7",
    icon: Icons.flag,
    location: 'ABD',
    type: 'Mountain',
    descp: 'Açıklama gelmesi gerekiyor bu kısıma.',
    price: '\$ 560',
  ),
  Travel(
    image: 'images/kirkju.webp',
    name: 'Kirkjufell Dağı',
    rate: "4.7",
    icon: Icons.flag,
    location: 'İzlanda',
    type: 'Mountain',
    descp: 'Açıklama gelmesi gerekiyor bu kısıma.',
    price: '\$ 560',
  ),
];
