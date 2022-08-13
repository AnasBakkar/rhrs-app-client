import 'package:flutter/material.dart';
import 'package:rhrs_app/models/auth.dart';
import 'package:rhrs_app/models/facility.dart';
import 'package:rhrs_app/models/profile.dart';
import 'package:rhrs_app/providers/bookings.dart';
import 'package:rhrs_app/providers/facilities.dart';
import 'package:rhrs_app/screens/Navigation_bar.dart';
import 'package:rhrs_app/screens/edit_profile_screen.dart';
import 'package:rhrs_app/screens/facilities_list.dart';
import 'package:rhrs_app/screens/facility_details_screen.dart';
import 'package:rhrs_app/screens/home_screen.dart';
import 'package:rhrs_app/screens/introcution_screen.dart';
import 'package:rhrs_app/screens/profile_screen.dart';
import 'package:rhrs_app/screens/search_screen.dart';
import 'package:rhrs_app/screens/test_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/auth_screen.dart';
import 'theme_cusomized.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome')?? false;
  runApp(MyApp(showHome:showHome));
}

class MyApp extends StatelessWidget {
  final bool showHome;

  const MyApp({@required this.showHome});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>Facilities()),
        ChangeNotifierProvider(create: (_)=>Facility()),
        ChangeNotifierProvider(create: (_)=>Auth()),
        ChangeNotifierProvider(create: (_)=>Profile()),
        ChangeNotifierProvider(create: (_)=>Bookings()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeCustomed,/*ThemeData(
              primaryColor: /*Color(0xffFA6933)*/ /*Colors.blueAccent*/ /*Color(0xffFF5A5F)*/ /*Color(0xff7868E6)*/ Color(0XFF6A62B7)/*Colors
                  .deepOrangeAccent*/,
              accentColor: /*Color(0xffFA6933)*/ Colors
                  .black54 /*Color(0xff0d1137)*/,
              ),*/

          home: /*showHome ? AuthScreen() : IntroductionScreen()*/
              auth.isAuth?
                  NavyBar() :
                  FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (ctx, authResultSnapShot) =>
                   AuthScreen())
          ,
          routes: {
            AuthScreen.routeName: (ctx) => AuthScreen(),
            NavyBar.routeName: (ctx) => NavyBar(),
            FacilitiesList.routeName: (ctx) => FacilitiesList(),
            DetailScreen.routeName: (ctx) => DetailScreen(),
            Auth.routeName: (ctx) => AuthScreen(),
            NewDetailsScreen.routeName : (ctx) => NewDetailsScreen(),
            ProfileScreen.routeName : (ctx) => ProfileScreen(),
            HomeScreen.routeName : (ctx) => HomeScreen(),
            EditProfile.routeName : (ctx) => EditProfile(),
            SearchScreen.routeName : (ctx) => SearchScreen(),
          },
        ),
      ),
    );
  }
}
