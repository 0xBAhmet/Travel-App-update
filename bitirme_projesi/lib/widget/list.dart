import 'package:bitirme_projesi/db/user.dart';
import 'package:bitirme_projesi/model/travel.dart';
import 'package:bitirme_projesi/widget/locations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

List<Travel> display_list = travel;

class Listeleme extends StatelessWidget {
  final List<Travel> travel;
  const Listeleme(
    this.travel,
  );

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // print(locationList.travel[1].type);

    Locations renderLocations(int index) {
      return Locations(travel[index]);
    }

    return Container(
      width: width * 0.9,
      height: 325,
      // color: Colors.red,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: travel.length,
        itemBuilder: ((context, index) => renderLocations(index)),
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          width: 15,
        ),
      ),
    );
  }
}
