// ignore_for_file: prefer_const_constructors
import 'package:bitirme_projesi/db/user.dart';
import 'package:bitirme_projesi/model/Colors.dart';
import 'package:bitirme_projesi/widget/bottomSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

import '../bloc/settings_cubit.dart';
import '../localizations/localizations.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({
    super.key,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(110);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late Isar isar;
  late final SettingsCubit settings = context.read<SettingsCubit>();

  askLogout() {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(AppLocalizations.of(context).getTranslate("logout")),
        content:
            Text(AppLocalizations.of(context).getTranslate("logout_confirm")),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text(AppLocalizations.of(context).getTranslate("yes")),
            onPressed: () {
              settings.userLogout();
              GoRouter.of(context).push('/loginScreen');
            },
          ),
          CupertinoDialogAction(
            child: Text(AppLocalizations.of(context).getTranslate("no")),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void initState() {
    super.initState();
    isar = Provider.of<Isar>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SheetBottom(
                content: Column(
                  children: [
                    //burası fotoğrafın gözükeceği yer
                    Center(
                        child: Container(
                      child: InkWell(
                        onTap: () {
                          print("sa");
                        },
                        child: Icon(
                          Iconsax.user,
                          color: screenColor.black,
                          size: 50,
                        ),
                      ),
                      margin: EdgeInsets.only(top: 35),
                      height: 180,
                      width: 200,
                      decoration: BoxDecoration(
                        color: screenColor.white,
                        shape: BoxShape.circle,
                      ),
                    )),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context).getTranslate("name") +
                              " : ${settings.state.userInfo.isNotEmpty ? settings.state.userInfo[0] : ''}",
                          style: GoogleFonts.poppins(
                              fontSize: 18, color: screenColor.white),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context).getTranslate("phone") +
                              " : ${settings.state.userInfo.length >= 4 ? settings.state.userInfo[3] : ''}",
                          style: GoogleFonts.poppins(
                              fontSize: 18, color: screenColor.white),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: settings.state.darkMode
                          ? Color.fromARGB(27, 24, 43, 255)
                          : Color.fromARGB(255, 52, 112, 161),
                      child: IconButton(
                        onPressed: () => {
                          GoRouter.of(context).push('/settings'),
                        },
                        icon: Icon(Iconsax.setting),
                        color: screenColor.white,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: settings.state.darkMode
                          ? Color.fromARGB(27, 24, 43, 255)
                          : Color.fromARGB(255, 52, 112, 161),
                      child: IconButton(
                        onPressed: () => {
                          GoRouter.of(context).push('/favories'),
                        },
                        icon: Icon(Iconsax.heart),
                        color: screenColor.white,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: settings.state.darkMode
                          ? Color.fromARGB(27, 24, 43, 255)
                          : Color.fromARGB(255, 52, 112, 161),
                      child: IconButton(
                        splashColor: screenColor.transparent,
                        onPressed: () => {
                          // GoRouter.of(context).push('/loginScreen'),
                          askLogout()
                          // Navigator.pushNamed(context, '/loginScreen')
                        },
                        icon: Icon(Icons.close),
                        color: screenColor.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
