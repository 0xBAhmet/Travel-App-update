import 'dart:developer';
import 'package:bitirme_projesi/bloc/settings_cubit.dart';
import 'package:bitirme_projesi/model/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../localizations/localizations.dart';

class Categories extends StatefulWidget {
  Function filterTravel;
  Categories({Key? mykey, required this.filterTravel}) : super(key: mykey);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> tags = [];
  int tag = -1;
  late final SettingsCubit setting;

  int selectItem = -1;

  bool beachSelected = false;
  @override
  void initState() {
    setting = context.read<SettingsCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    List<String> options = [
      AppLocalizations.of(context).getTranslate("beach"),
      AppLocalizations.of(context).getTranslate("camp"),
      AppLocalizations.of(context).getTranslate("mountain"),
      AppLocalizations.of(context).getTranslate("history"),
    ];
    List<Map<String, dynamic>> categoriesList = [
      {"id": AppLocalizations.of(context).getTranslate("beach")},
      {
        "id": AppLocalizations.of(context).getTranslate("camp"),
      },
      {
        "id": AppLocalizations.of(context).getTranslate("mountain"),
      },
      {
        "id": AppLocalizations.of(context).getTranslate("history"),
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Container(
            height: 50,
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => Container(
                      child: GestureDetector(
                        //...

                        // Öğe seçildiğinde, seçilen öğeyi güncelleyin ve filtreTravel işlevini çağırın.
                        onTap: () {
                          setState(() {
                            // Seçilen öğe, tıklanan öğeyle aynı değilse, seçilen öğeyi güncelleyin.
                            if (selectItem != index) {
                              selectItem = index;
                              var deneme = categoriesList[index]["id"];
                              print(deneme);
                              // Filtreleme işlevini çağırın ve seçilen öğenin ID'sini iletin.
                              widget.filterTravel(
                                  categoriesList[index]["id"], false);
                            }
                            // Seçilen öğe, tıklanan öğeyle aynı ise, seçilen öğeyi sıfırlayın.
                            else {
                              selectItem = -1;
                              // Filtreleme işlevini çağırın ve boş bir dize iletin.
                              widget.filterTravel("", false);
                            }
                          });
                        },
                        child: Card(
                          color: selectItem == index
                              ? setting.state.darkMode
                                  ? Color.fromARGB(255, 52, 112, 161)
                                  : screenColor.themeColor
                              : setting.state.darkMode
                                  ? Color.fromARGB(255, 44, 57, 73)
                                  : Color.fromARGB(255, 149, 167, 199),
                          // ignore: sort_child_properties_last
                          child: SizedBox(
                            width: 90,
                            child: Center(
                              child: Text(
                                categoriesList[index]["id"],
                                style: selectItem == index
                                    ? TextStyle(
                                        color: screenColor.white, fontSize: 15)
                                    : TextStyle(color: Colors.grey.shade700),
                              ),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                separatorBuilder: (_, index) => SizedBox(
                      width: 5,
                    ),
                itemCount: categoriesList.length),
          ),
        ],
      ),
    );
  }
}
// result = list.where((listItem)=>listItem.type == 'Camp')
