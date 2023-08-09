import 'package:bitirme_projesi/db/user.dart';
import 'package:bitirme_projesi/screen/favories.dart';
import 'package:bitirme_projesi/screen/heroScreen.dart';
import 'package:bitirme_projesi/screen/homepage.dart';
import 'package:bitirme_projesi/screen/initial_screen.dart';
import 'package:bitirme_projesi/screen/loginScreen.dart';
import 'package:bitirme_projesi/screen/logoScreen.dart';
import 'package:bitirme_projesi/screen/mobileScreen.dart';
import 'package:bitirme_projesi/screen/registerScreen.dart';
import 'package:bitirme_projesi/screen/settings_screen.dart';
import 'package:bitirme_projesi/screen/updatePasswd.dart';
import 'package:bitirme_projesi/screen/update_info.dart';
import 'package:bitirme_projesi/themes/themes.dart';
import 'package:bitirme_projesi/widget/titleWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'bloc/settings_cubit.dart';
import 'bloc/settings_state.dart';
import 'localizations/localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isar = await openIsar();
  runApp(Provider.value(
      value: isar,
      child: MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => TravelProvider()),
      ], child: MyApp())));
}

late User user;

Future<Isar> openIsar() async {
  final isar = await Isar.open([UserSchema], directory: '');
  return isar;
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => InitialScreen(),
    ),
    GoRoute(
      path: '/logoinit',
      builder: (context, state) => LogoScreen(),
    ),
    GoRoute(
      path: '/registerScreen',
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: '/homePage',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => SettingsScreen(),
    ),
    GoRoute(
      name:
          "changePass", //pushname kullanırsak buradaki adı yazıyoruz push kullanırsak pathteki yeri yazıyoruz
      path: '/change-Pass',
      builder: (context, state) => ChangePass(),
    ),
    GoRoute(
      name:
          "titleWidget", //pushname kullanırsak buradaki adı yazıyoruz push kullanırsak pathteki yeri yazıyoruz
      path: '/titleWidget',
      builder: (context, state) => titleWidget(),
    ),
    GoRoute(
      name:
          "favories", //pushname kullanırsak buradaki adı yazıyoruz push kullanırsak pathteki yeri yazıyoruz
      path: '/favories',
      builder: (context, state) => Favories(),
    ),
    GoRoute(
      name:
          "update", //pushname kullanırsak buradaki adı yazıyoruz push kullanırsak pathteki yeri yazıyoruz
      path: '/update',
      builder: (context, state) => UpdateInfo(),
    ),

    // GoRoute(
    //   path: '/hero/:travel',
    //   builder: (context, state) => HeroScreen(
    //     travel: state.params['travel'],
    //   ),
    // ),
    GoRoute(path: '/loginScreen', builder: (context, state) => LoginScreen()),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(SettingsState()),
      child:
          BlocBuilder<SettingsCubit, SettingsState>(builder: (context, state) {
        return MaterialApp.router(
          // materialapp.router yapıp configi aç kullanırken GOROUTERİ
          title: 'Travel App',
          // routerConfig: _router,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLanguages
              .map((e) => Locale(e, ""))
              .toList(),
          locale: Locale(state.language, ""),
          // routes: {
          //   '/homeScreen': (context) => HomePage(),
          //   '/registerScreen': (context) => RegisterScreen(),
          //   '/changePass': (context) => ChangePass(),
          //   '/loginScreen': (context) => LoginScreen(),
          // },
          routerConfig: _router,
          themeMode: state.darkMode ? ThemeMode.dark : ThemeMode.light,
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          // home: LoginScreen(),
        );
      }),
    );
  }
}
// return BlocProvider(
//       create: (context) => SettingsCubit(SettingsState()),
//       child:
//           BlocBuilder<SettingsCubit, SettingsState>(builder: (context, state) {
//         return MaterialApp.router(
//           // materialapp.router yapıp configi aç kullanırken GOROUTERİ
//           title: 'Travel App',
//           // routerConfig: _router,
//           debugShowCheckedModeBanner: false,
//           darkTheme: ThemeData(
//             brightness: Brightness.dark,
//             /* dark theme settings */
//           ),
//           // routes: {
//           //   '/homeScreen': (context) => HomePage(),
//           //   '/registerScreen': (context) => RegisterScreen(),
//           //   '/changePass': (context) => ChangePass(),
//           //   '/loginScreen': (context) => LoginScreen(),
//           // },
//           routerConfig: _router,
//           themeMode: ThemeMode.dark,
//           theme: ThemeData.dark(),
//           // home: LoginScreen(),
//         );
//       }),
//     );