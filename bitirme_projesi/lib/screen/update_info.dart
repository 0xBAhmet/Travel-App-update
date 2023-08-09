import 'package:bitirme_projesi/db/user.dart';
import 'package:bitirme_projesi/model/Colors.dart';
import 'package:bitirme_projesi/widget/inputWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

import '../bloc/settings_cubit.dart';
import '../bloc/settings_cubit.dart';
import '../localizations/localizations.dart';
import '../widget/snackDesign.dart';

class UpdateInfo extends StatefulWidget {
  const UpdateInfo({super.key});

  @override
  State<UpdateInfo> createState() => _UpdateInfoState();
}

class _UpdateInfoState extends State<UpdateInfo> {
  late final SettingsCubit settings = context.read<SettingsCubit>();

  String email = "";
  String name = "";
  String phone = "";
  String passwd = "";
  late Isar isar;
  bool flag = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwdController = TextEditingController();
  TextEditingController passwdController1 = TextEditingController();

  Edituser() async {
    final k = await isar.users.where().filter().emailEqualTo(email).findFirst();
    if (k?.email == email) {
      if (passwdController.text == passwdController1.text) {
        if (passwdController.text.isNotEmpty) {
          if (name.isNotEmpty && phone.isNotEmpty) {
            flag = true;
            final edittuser = User()
              ..email = email
              ..name = name
              ..passwd = passwd // Güncellenen şifre değerini atayın.
              ..id = k!.id
              ..phone = phone;

            await isar.writeTxn(
              () async {
                await isar.users.put(edittuser);
                setState(() {
                  nameController.text = "";
                  passwdController1.text = "";
                  passwdController.text = "";
                  passwd = ""; // Şifreyi temizleyin.
                });
              },
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: snackDesign(
                  text1:
                      AppLocalizations.of(context).getTranslate("changed_pass"),
                  text2: "",
                  colorSnack: screenColor.snackGreen,
                  image: Image.asset("images/ok.png"),
                  image2: Image.asset("images/blur.png"),
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: screenColor.transparent,
                elevation: 0,
              ),
            );
            GoRouter.of(context).push("/loginScreen");
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: snackDesign(
                  text1: AppLocalizations.of(context).getTranslate("warning"),
                  text2: AppLocalizations.of(context).getTranslate("fill_Box"),
                  colorSnack: screenColor.snackRed,
                  image: Image.asset("images/danger.png"),
                  image2: Image.asset("images/paint-splash.png"),
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: screenColor.transparent,
                elevation: 0,
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: snackDesign(
                text1: AppLocalizations.of(context).getTranslate("warning"),
                text2: AppLocalizations.of(context).getTranslate("empty_pass"),
                colorSnack: screenColor.snackRed,
                image: Image.asset("images/danger.png"),
                image2: Image.asset("images/paint-splash.png"),
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: screenColor.transparent,
              elevation: 0,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: snackDesign(
              text1: AppLocalizations.of(context).getTranslate("warning"),
              text2: AppLocalizations.of(context).getTranslate("match_pass"),
              colorSnack: screenColor.snackRed,
              image: Image.asset("images/danger.png"),
              image2: Image.asset("images/paint-splash.png"),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: screenColor.transparent,
            elevation: 0,
          ),
        );
      }
    }
    // else if (email.isNotEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: snackDesign(
    //         text1: AppLocalizations.of(context).getTranslate("warning"),
    //         text2: AppLocalizations.of(context).getTranslate("available_mail"),
    //         colorSnack: screenColor.snackRed,
    //         image: Image.asset("images/danger.png"),
    //         image2: Image.asset("images/paint-splash.png"),
    //       ),
    //       behavior: SnackBarBehavior.floating,
    //       backgroundColor: screenColor.transparent,
    //       elevation: 0,
    //     ),
    //   );
    // }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: snackDesign(
            text1: AppLocalizations.of(context).getTranslate("warning"),
            text2: AppLocalizations.of(context).getTranslate("mail_required"),
            colorSnack: screenColor.snackRed,
            image: Image.asset("images/danger.png"),
            image2: Image.asset("images/paint-splash.png"),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: screenColor.transparent,
          elevation: 0,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    isar = Provider.of<Isar>(context, listen: false);
    email = settings.state.userInfo[2];
    name = settings.state.userInfo[0];
    phone = settings.state.userInfo[3];
    nameController.text = name;
    phoneController.text = phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: settings.state.darkMode
            ? Colors.transparent
            : screenColor.themeColor,
        elevation: 0,
        toolbarHeight: 50,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 330,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                  ),
                  color: new Color(0xff1f3b83),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 44, 93, 114),
                      Color(0xFF203A43),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/tw.png"),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        AppLocalizations.of(context)
                            .getTranslate("change_pass"),
                        style: GoogleFonts.roboto(
                            fontSize: 16, color: screenColor.white),
                      ),
                    )
                  ],
                )),
              ),
              SizedBox(
                height: 70,
              ),
              InputWidget(
                icon: Iconsax.user,
                text: AppLocalizations.of(context).getTranslate("name"),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(20),
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
                obscureText: false,
                showImage: false,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                textEdit: nameController,
              ),
              InputWidget(
                icon: Iconsax.call,
                text: AppLocalizations.of(context).getTranslate("phone"),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.singleLineFormatter,
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                obscureText: false,
                showImage: false,
                onChanged: (value) {
                  setState(() {
                    phone = value;
                  });
                },
                textEdit: phoneController,
              ),
              InputWidget(
                icon: Iconsax.key,
                text: AppLocalizations.of(context).getTranslate("password"),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(20),
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
                obscureText: true,
                showImage: true,
                onChanged: (value) {
                  setState(() {
                    passwd = value;
                  });
                },
                textEdit: passwdController,
              ),
              InputWidget(
                icon: Iconsax.key,
                text: AppLocalizations.of(context)
                    .getTranslate("confirm_password"),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(20),
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
                obscureText: true,
                showImage: true,
                onChanged: (value) {
                  setState(() {
                    // passwd = value;
                  });
                },
                textEdit: passwdController1,
              ),
              SizedBox(
                height: 70,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () {
                    if (flag) {
                      Edituser();
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: new Color(0xff1f3b83),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 44, 93, 114),
                          Color(0xFF203A43),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)
                          .getTranslate("update_password"),
                      style: GoogleFonts.roboto(
                          fontSize: 16, color: screenColor.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
