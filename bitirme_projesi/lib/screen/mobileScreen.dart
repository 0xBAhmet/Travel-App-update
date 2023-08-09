import 'package:bitirme_projesi/db/user.dart';
import 'package:bitirme_projesi/model/Colors.dart';
import 'package:bitirme_projesi/model/travel.dart';
import 'package:bitirme_projesi/widget/category.dart';
import 'dart:developer';
import 'package:bitirme_projesi/widget/inputSearch.dart';
import 'package:bitirme_projesi/widget/list.dart';
import 'package:bitirme_projesi/widget/titleWidget.dart';
import 'package:flutter/material.dart';

class mobileScreen extends StatefulWidget {
  const mobileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<mobileScreen> createState() => _mobileScreenState();
}

class _mobileScreenState extends State<mobileScreen> {
  List<Travel> _travelData = travel;
  String filteredInputText = "";
  String filteredCategory = "";

  void updateTravelData() {
    List<Travel> filteredList = [];
    // print("sa" + filteredInputText);
    // print(filteredCategory);
    if (filteredInputText == "" && filteredCategory == "") {
      filteredList = travel;
    } else if (filteredInputText == "" && filteredCategory != "") {
      filteredList =
          travel.where((element) => element.type == filteredCategory).toList();
    } else if (filteredInputText != "" && filteredCategory == "") {
      filteredList = travel
          .where((element) => element.name
              .toLowerCase()
              .contains(filteredInputText.toLowerCase()))
          .toList();
    } else if (filteredInputText != "" && filteredCategory != "") {
      filteredList = travel
          .where((element) => element.name
              .toLowerCase()
              .contains(filteredInputText.toLowerCase()))
          .toList()
          .where((element) => element.type == filteredCategory)
          .toList();
    }
    setState(() {
      _travelData = filteredList;
    });
  }

  void filterTravel(String text, bool isSearch) {
    if (isSearch == true) {
      setState(() {
        filteredInputText = text;
      });
    } else {
      setState(() {
        filteredCategory = text;
      });
    }
    updateTravelData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Başlık Yazı Kısmı
        titleWidget(),
        SizedBox(
          height: 35,
        ),
        InputSearch(filterTravel),
        SizedBox(
          height: 25,
        ),
        // Kategoriler kısmı. Listview ile yapıldı
        Categories(
          filterTravel: filterTravel,
        ),

        SizedBox(
          height: 15,
        ),
        _travelData.length == 0
            ? Center(
                heightFactor: 10,
                child: Text(
                  "Bulunamadı",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Listeleme(_travelData),
      ],
    );
  }
}
