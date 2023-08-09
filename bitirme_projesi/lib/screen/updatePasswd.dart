import 'package:bitirme_projesi/db/user.dart';
import 'package:bitirme_projesi/model/Colors.dart';
import 'package:bitirme_projesi/widget/inputWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

import '../localizations/localizations.dart';
import '../widget/snackDesign.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({super.key});

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  String email = "";
  String phone = "";
  String passwd = "";
  late Isar isar;
  bool flag = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwdController = TextEditingController();
  TextEditingController passwdController1 = TextEditingController();

  Edituser() async {
    final k = await isar.users.where().filter().emailEqualTo(email).findFirst();
    if (k?.email == email) {
      if (passwdController.text == passwdController1.text) {
        if (passwdController.text.isNotEmpty) {
          flag = true;
          final edittuser = User()
            ..email = email
            ..name = k?.name
            ..passwd = passwd
            ..id = k!.id
            ..phone = k.phone;

          await isar.writeTxn(
            () async {
              await isar.users.put(edittuser);
              setState(() {
                emailController.text = "";
                passwdController1.text = "";
                passwdController.text = "";
                email = "";
                passwd = "";
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
    } else if (email.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: snackDesign(
            text1: AppLocalizations.of(context).getTranslate("warning"),
            text2: AppLocalizations.of(context).getTranslate("available_mail"),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
