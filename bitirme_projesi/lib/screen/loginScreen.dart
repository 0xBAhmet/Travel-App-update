import 'package:bitirme_projesi/db/user.dart';
import 'package:bitirme_projesi/model/Colors.dart';
import 'package:bitirme_projesi/screen/homepage.dart';
import 'package:bitirme_projesi/widget/inputWidget.dart';
import 'package:bitirme_projesi/widget/snackDesign.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

import '../bloc/settings_cubit.dart';
import '../localizations/localizations.dart';
import '../storage/storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String passwd = "";
  late final SettingsCubit settings;

  bool flag = false;
  late Isar isar;
  // late final SettingsCubit settings;
  AppStorage appStorage = AppStorage();

  TextEditingController passwdController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void checkUser() async {
    final user =
        await isar.users.where().filter().emailEqualTo(email).findAll();
    if (user.isEmpty) {
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
      return;
    }
    for (var i in user) {
      String dbEmail = i.email.toString();
      String dbPass = i.passwd.toString();

      if (dbEmail == email && dbPass == passwd) {
        flag = true;
        // settings.userLogin();
        // await userManager.saveUserCredentials(email, passwd);
        List<String> data = [
          i.name.toString(),
          i.passwd.toString(),
          i.email.toString(),
          i.phone.toString(),
          i.id.toString(),
        ];
        settings.userLogin(
            data); // userLogin çağrısında data'yı userInfo olarak kullan
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomePage(
                  //kullanıcı adını da atabiliriz bilgileri değiştirmek için.
                  );
            },
          ),
        );
        // GoRouter.of(context).push('/screen1');
      } else if (dbEmail != email || dbPass != passwd) {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: snackDesign(
                text1: AppLocalizations.of(context).getTranslate("warning"),
                text2: AppLocalizations.of(context)
                    .getTranslate("email_and_password"),
                colorSnack: screenColor.snackRed,
                image: Image.asset("images/danger.png"),
                image2: Image.asset("images/paint-splash.png"),
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: screenColor.transparent,
              elevation: 0,
            ),
          );
        });
      }
    }
    if (passwdController.text.isEmpty && emailController.text.isEmpty) {
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
  }

  void initState() {
    super.initState();
    settings = context.read<SettingsCubit>();

    isar = Provider.of<Isar>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              fit: BoxFit.cover)),
                    ),
                    // ignore: prefer_const_constructors
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        AppLocalizations.of(context).getTranslate("login"),
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
              // ignore: prefer_const_constructors
              InputWidget(
                icon: Iconsax.sms,
                text: AppLocalizations.of(context).getTranslate("enter_email"),
                obscureText: false,
                showImage: false,
                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter,
                  LengthLimitingTextInputFormatter(20),
                ],
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                textEdit: emailController,
              ),
              // ignore: prefer_const_constructors
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

              Container(
                margin: EdgeInsets.only(right: 20, top: 20),
                alignment: Alignment.centerRight,
                child: InkWell(
                    onTap: () {
                      // Navigator.of(context).pushNamed("/changePass");
                      GoRouter.of(context).pushNamed('changePass');
                    },
                    child: Text(
                      AppLocalizations.of(context).getTranslate("forget_pass"),
                    )),
              ),
              SizedBox(
                height: 70,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    // Navigator.of(context).pushReplacementNamed("/homeScreen");
                    if (flag) {
                    } else {
                      checkUser();
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
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color.fromARGB(255, 44, 93, 114),
                          Color(0xFF203A43),
                        ],
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context).getTranslate("login"),
                      style: TextStyle(color: screenColor.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context).getTranslate("need_account"),
                    ),
                    GestureDetector(
                      onTap: (() {
                        // Navigator.of(context)
                        //     .pushReplacementNamed('/registerScreen');
                        // Navigator.of(context).pushNamed("/registerScreen");
                        GoRouter.of(context).push("/registerScreen");
                      }),
                      child: Text(
                        AppLocalizations.of(context)
                            .getTranslate("register_now"),
                        style: TextStyle(
                          color: Color(0xff058cc0),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
