import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:rhrs_app/screens/bookings_screen.dart';
import 'package:rhrs_app/screens/chats_screen.dart';
import 'package:rhrs_app/screens/favorites_screen.dart';
import 'package:rhrs_app/screens/settings_screen.dart';
import 'package:rhrs_app/screens/search_screen.dart';
import 'package:rhrs_app/screens/settings_screen.dart';
import 'home_screen.dart';

class NavyBar extends StatefulWidget {
  static const routeName = '/NavyBar';

  @override
  _NavyBarState createState() => _NavyBarState();
}

class _NavyBarState extends State<NavyBar> {
  List _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      {'page': SearchScreen(), 'title': 'Search'},
      {'page': FavoritesScreen(), 'title': 'Favorites'},
      {'page' : TravelApp(),'title': 'Bookings'},
      {'page': ChatsScreen(), 'title': 'Chats'},
      {'page': SettingsScreen(), 'title': 'Settings'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
        elevation: 0.0,
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedPageIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => _selectedPageIndex = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.search),
            title: Text(
              'search',
              style: Theme.of(context).textTheme.headline6,
            ),
            activeColor: Theme.of(context).primaryColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.favorite),
            title:
                Text('Favorites', style: Theme.of(context).textTheme.headline6),
            activeColor: Theme.of(context).primaryColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.save),
            title: Text('Bookings', style: Theme.of(context).textTheme.headline6),
            activeColor: Theme.of(context).primaryColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.chat),
            title: Text('Chats', style: Theme.of(context).textTheme.headline6),
            activeColor: Theme.of(context).primaryColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title:
                Text('Settings', style: Theme.of(context).textTheme.headline6),
            activeColor: Theme.of(context).primaryColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
