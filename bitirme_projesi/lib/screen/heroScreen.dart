// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:bitirme_projesi/db/user.dart';
import 'package:bitirme_projesi/model/Colors.dart';
import 'package:bitirme_projesi/model/travel.dart';
import 'package:bitirme_projesi/screen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../bloc/settings_cubit.dart';
import '../localizations/localizations.dart';
import 'favories.dart';

class HeroScreen extends StatefulWidget {
  final Travel travel;

  const HeroScreen({super.key, required this.travel});

  @override
  State<HeroScreen> createState() => _HeroScreenState();
}

class _HeroScreenState extends State<HeroScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final double circleYukseklik = 50;

    String text;
    late final SettingsCubit settings = context.read<SettingsCubit>();

    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: widget.travel.image,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image(
                    image: AssetImage(
                      widget.travel.image,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Material(
                        color: Colors.transparent,
                        child: ClipRRect(
                            child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 5,
                                  sigmaY: 5,
                                ),
                                child: Container(
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.transparent,
                                    child: IconButton(
                                      onPressed: () => {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    HomePage())))
                                      },
                                      icon: Icon(Icons.arrow_back),
                                      color: screenColor.white,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          screenColor.white.withOpacity(0.6),
                                          screenColor.white.withOpacity(0.1),
                                        ]),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Material(
                        color: screenColor.transparent,
                        child: ClipRRect(
                            child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 5,
                                  sigmaY: 5,
                                ),
                                child: Container(
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: screenColor.transparent,
                                    child: IconButton(
                                      onPressed: () => {},
                                      icon: Image.asset(
                                        "images/menu.webp",
                                      ),
                                      color: screenColor.white,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          screenColor.white.withOpacity(0.6),
                                          screenColor.white.withOpacity(0.1),
                                        ]),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ))),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 130,
                    left: 20,
                    right: 20,
                    child: Material(
                      color: screenColor.transparent,
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 5,
                            sigmaY: 5,
                          ),
                          child: Container(
                            height: 310,
                            width: width * 0.9,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    screenColor.white.withOpacity(0.6),
                                    Colors.black54.withOpacity(0.1),
                                  ]),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 50, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.travel.location,
                                    style: TextStyle(
                                        color: screenColor.white, fontSize: 22),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(widget.travel.name,
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: screenColor.white)),
                                      Row(
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                  color: screenColor.themeColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Iconsax.star5,
                                                  color: screenColor.white,
                                                ),
                                              )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)
                                                    .getTranslate("ratings"),
                                                style: TextStyle(
                                                    color: screenColor.grey),
                                              ),
                                              Text(widget.travel.rate),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    widget.travel.descp,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: (() {}),
                                    child: Container(
                                      width: width * 0.9,
                                      decoration: BoxDecoration(
                                        color: screenColor.themeColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Center(
                                            child: Text(
                                          AppLocalizations.of(context)
                                              .getTranslate("choose_dates"),
                                          style: TextStyle(
                                            color: screenColor.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 410,
                    left: 40,
                    child: Center(
                      child: Material(
                        color: screenColor.transparent,
                        child: Consumer<TravelProvider>(
                          builder: (context, travelProvider, _) {
                            final isFavorite = travelProvider.isFavorite(
                                settings.state.userInfo[4], widget.travel);
                            return CircleAvatar(
                              backgroundColor: screenColor.themeColor,
                              radius: circleYukseklik / 2,
                              child: IconButton(
                                onPressed: () {
                                  if (isFavorite) {
                                    travelProvider.removeFavorite(
                                        settings.state.userInfo[4],
                                        widget.travel);
                                  } else {
                                    travelProvider.addFavorite(
                                        settings.state.userInfo[4],
                                        widget.travel);
                                  }
                                },
                                icon: Icon(
                                  isFavorite ? Iconsax.heart5 : Iconsax.heart,
                                ),
                                color: screenColor.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        children: [
                          deneme(
                            width: width,
                            text: "Mo. 16 Sep",
                            text2: "21°",
                            image: Image.asset("images/rain.png"),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          deneme(
                            width: width,
                            text: AppLocalizations.of(context)
                                .getTranslate("price"),
                            text2: widget.travel.price,
                            image: Image.asset("images/coins.png"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class deneme extends StatelessWidget {
  final String text;
  final String text2;
  final Image image;
  const deneme({
    Key? key,
    required this.width,
    required this.text,
    required this.text2,
    required this.image,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: width * 0.4,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              screenColor.grey.withOpacity(0.6),
              Colors.black54.withOpacity(0.5),
            ]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Material(
          color: screenColor.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(color: screenColor.grey),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text2,
                    style: TextStyle(fontSize: 22, color: screenColor.white),
                  ),
                  image
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
