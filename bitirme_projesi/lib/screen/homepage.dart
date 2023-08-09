// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import

import 'package:bitirme_projesi/db/user.dart';
import 'package:bitirme_projesi/screen/mobileScreen.dart';
import 'package:bitirme_projesi/widget/bottomNav.dart';
import 'package:bitirme_projesi/widget/customappBar.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

import '../bloc/settings_cubit.dart';

class HomePage extends StatefulWidget {
  late int? sayi;
  HomePage({super.key, this.sayi});

  @override
  State<HomePage> createState() => _HomePageState();
}

int index = 0;

class _HomePageState extends State<HomePage> {
  final title = "Where do you want to be ?";
  late Isar isar;
  late final SettingsCubit settings;

  void indexAl(int index1) {
    print("indexAl");
    print(index1);

    setState(() {
      index = index1;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    settings = context.read<SettingsCubit>();

    super.initState();
    isar = Provider.of<Isar>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final screens = [mobileScreen(), CustomAppBar()];

    getScreenByIndex(int index) {
      print("getscreenBy");
      print(index);
      return screens[index];
    }

    // print(widget.user.email);
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        // child: ResponsiveLayout(
        //     mobileBody: mobileScreen(
        //       name: widget.name,
        //     ),
        //     desktopBody: Container(
        //       child: Center(child: Text("Desktop..")),
        //     ),
        //     tabletBody: Container(
        //       child: Center(
        //         child: Text("Tablet.."),
        //       ),
        //     )),
        child: getScreenByIndex(index),
      ),
    );
  }
}
