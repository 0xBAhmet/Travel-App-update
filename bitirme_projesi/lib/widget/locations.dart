// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bitirme_projesi/db/user.dart';
import 'package:bitirme_projesi/model/Colors.dart';
import 'package:bitirme_projesi/model/travel.dart';
import 'package:bitirme_projesi/screen/favories.dart';
import 'package:bitirme_projesi/screen/heroScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../bloc/settings_cubit.dart';

class Locations extends StatefulWidget {
  final Travel travel;

  Locations(this.travel);

  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  late final SettingsCubit settings;

  @override
  void initState() {
    super.initState();
    settings = context.read<SettingsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final double containerHeight = 300;
    final double circleYukseklik = 50;

    final double top = containerHeight - circleYukseklik / 2;

    return LayoutBuilder(
      builder: (context, contraints) => Container(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 310,
              width: width * 0.8,
              decoration: BoxDecoration(
                  color: settings.state.darkMode
                      ? Color.fromARGB(255, 57, 66, 80)
                      : Color.fromARGB(255, 160, 193, 219),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HeroScreen(travel: widget.travel),
                          ),
                        );
                      },
                      child: Hero(
                        tag: widget.travel.image,
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: new DecorationImage(
                                image: AssetImage(widget.travel.image),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.travel.name),
                              Row(
                                children: [
                                  Text(widget.travel.rate),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 14,
                                    color: screenColor.themeColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                widget.travel.icon,
                                size: 14,
                                color: screenColor.themeColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.travel.location,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.copyWith(fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: top,
              right: 20,
              child: Center(
                child: Consumer<TravelProvider>(
                  builder: (context, travelProvider, _) {
                    final isFavorite = travelProvider.isFavorite(
                        settings.state.userInfo.length >= 5
                            ? settings.state.userInfo[4]
                            : '',
                        widget.travel);
                    return CircleAvatar(
                      backgroundColor: screenColor.themeColor,
                      radius: circleYukseklik / 2,
                      child: IconButton(
                        onPressed: () {
                          if (isFavorite) {
                            travelProvider.removeFavorite(
                              settings.state.userInfo.length >= 5
                                  ? settings.state.userInfo[4]
                                  : '',
                              widget.travel,
                            );
                          } else {
                            travelProvider.addFavorite(
                                settings.state.userInfo.length >= 5
                                    ? settings.state.userInfo[4]
                                    : '',
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
            )
          ],
        ),
      ),
    );
  }
}
