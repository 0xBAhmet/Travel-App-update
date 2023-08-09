import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:bitirme_projesi/model/Colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SheetBottom extends StatelessWidget {
  late Widget content;
  SheetBottom({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Center(
      child: InkWell(
        splashColor: screenColor.themeColor,
        highlightColor: screenColor.transparent,
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          showModalBottomSheet(
            constraints: BoxConstraints(minHeight: 75),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  // <-- SEE HERE
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25)),
            ),
            context: context,
            builder: (context) {
              return Container(
                width: double.infinity,
                height: height / 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      // <-- SEE HERE
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color(0xFF0F2027),
                        Color(0xFF203A43),
                        Color(0xFF2C5364),
                      ],
                    )),
                child: Column(
                  children: [
                    Container(child: content),
                  ],
                ),
              );
            },
          );
        },
        child: CircleAvatar(
          radius: 25,
          backgroundColor: screenColor.transparent,
          backgroundImage: AssetImage("images/man.png"),
        ),
      ),
    );
  }
}
