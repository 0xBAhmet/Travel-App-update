import 'package:bitirme_projesi/model/Colors.dart';
import 'package:bitirme_projesi/model/travel.dart';
import 'package:bitirme_projesi/screen/heroScreen.dart';
import 'package:bitirme_projesi/widget/list.dart';
import 'package:flutter/material.dart';

import '../localizations/localizations.dart';
import 'locations.dart';

class InputSearch extends StatelessWidget {
  final Function filterFunction;
  const InputSearch(this.filterFunction);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    void updateList(String value) {
      filterFunction(value, true);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 6,
            child: Container(
              width: width * 0.8,
              child: TextField(
                onChanged: (value) {
                  updateList(value);
                }, //değer atadığımız yer,

                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(2),
                    hintText:
                        AppLocalizations.of(context).getTranslate("search"),
                    hintStyle:
                        TextStyle(color: Colors.grey.shade700, fontSize: 14),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    fillColor: screenColor.cardsColor,
                    filled: true,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          border: Border(
                              right: BorderSide(color: Colors.grey.shade700)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Image.asset("images/search16.png"),
                        ),
                      ),
                    )),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 1,
            child: Card(
              color: screenColor.themeColor,
              child: CircleAvatar(
                backgroundColor: screenColor.transparent,
                radius: 25,
                child: Icon(
                  Icons.location_pin,
                  color: Colors.white,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }
}
