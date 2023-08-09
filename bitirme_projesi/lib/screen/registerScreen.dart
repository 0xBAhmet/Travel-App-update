import 'package:bitirme_projesi/db/user.dart';
import 'package:bitirme_projesi/model/Colors.dart';
import 'package:bitirme_projesi/widget/inputWidget.dart';
import 'package:bitirme_projesi/widget/snackDesign.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../localizations/localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String name = "";
  String email = "";
  String phone = "";
  String passwd = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwdController = TextEditingController();
  bool goster = true;
  addUser() async {
    if (name.isEmpty || phone.isEmpty || email.isEmpty || passwd.isEmpty) {
      goster = false;
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
    } else {
      goster = true;
      final newUser = User()
        ..name = name
        ..email = email
        ..phone = phone
        ..passwd = passwd;

      await isar.writeTxn(
        () async {
          await isar.users.put(newUser);
          setState(
            () {
              nameController.text = "";
              emailController.text = "";
              phoneController.text = "";
              passwdController.text = "";
              name = "";
              email = "";
              phone = "";
              passwd = "";
            },
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: snackDesign(
                text1: AppLocalizations.of(context)
                    .getTranslate("succesful_register"),
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
        },
      );
    }
  }

  late Isar isar;

  @override
  void initState() {
    super.initState();
    isar = Provider.of<Isar>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50,
        iconTheme: IconThemeData(color: screenColor.black),
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
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color.fromARGB(255, 44, 93, 114),
                      Color(0xFF203A43),
                    ],
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
                        AppLocalizations.of(context).getTranslate("register"),
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
                icon: Iconsax.sms,
                text: AppLocalizations.of(context).getTranslate("enter_email"),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(20),
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
                obscureText: false,
                showImage: false,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                textEdit: emailController,
              ),
              InputWidget(
                icon: Iconsax.call,
                text: AppLocalizations.of(context).getTranslate("phone"),
                obscureText: false,
                showImage: false,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.singleLineFormatter,
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
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
                obscureText: true,
                showImage: true,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(15),
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
                onChanged: (value) {
                  setState(() {
                    passwd = value;
                  });
                },
                textEdit: passwdController,
              ),
              SizedBox(
                height: 70,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    addUser();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: new Color(0xff1f3b83),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color.fromARGB(255, 44, 93, 114),
                          Color(0xFF203A43),
                        ],
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context).getTranslate("register"),
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
