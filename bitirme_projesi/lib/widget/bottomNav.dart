import 'package:bitirme_projesi/model/Colors.dart';
import 'package:bitirme_projesi/screen/homepage.dart';
import 'package:bitirme_projesi/screen/loginScreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../model/travel.dart';
import '../screen/favories.dart';

typedef void IntCallback(int id);

class bottomNavigation extends StatefulWidget {
  final Function changeIndex;

  bottomNavigation({
    Key? key,
    required this.changeIndex,
  }) : super(key: key);

  int page = 0;

  @override
  State<bottomNavigation> createState() => _bottomNavigationState();
}

class _bottomNavigationState extends State<bottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: widget.page,
      color: screenColor.unselectColor,
      backgroundColor: screenColor.transparent,
      animationDuration: Duration(milliseconds: 500),
      items: [
        Icon(Icons.home),
        Icon(Icons.add),
        Icon(Iconsax.heart),
      ],
      onTap: (index) {
        widget.changeIndex(index); // index değerini gönder
      },
    );
  }
}

void setState(Null Function() param0) {}

  // class googleNavbar extends StatelessWidget {
  //   const googleNavbar({
  //     Key? key,
  //     required this.color_Theme,
  //   }) : super(key: key);

  //   final Color color_Theme;

  //   @override
  //   Widget build(BuildContext context) {
  //     return Container(
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  //         child: GNav(
  //             gap: 8,
  //             padding: EdgeInsets.all(25),
  //             tabActiveBorder: Border.all(color: color_Theme, width: 1),
  //             activeColor: Color.fromARGB(255, 52, 112, 161),
  //             tabs: [
  //               GButton(icon: Icons.home, text: 'Home'),
  //               GButton(
  //                 icon: Icons.add,
  //                 text: 'Add',
  //               ),
  //               GButton(
  //                 icon: Icons.bookmark_add,
  //                 text: 'Save',
  //               ),
  //             ]),
  //       ),
  //     );
  //   }
  // }
