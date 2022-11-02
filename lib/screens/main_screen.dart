import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../tabs/home.dart';
import '../tabs/movie.dart';
import '../tabs/rankings/ranking.dart';
import '../tabs/trends.dart';


class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<BottomNavigationBarItem> itemsNavigationBar = [
    const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.emoji_events_outlined), label: 'Ranking'),
    const BottomNavigationBarItem(icon: Icon(Icons.movie_outlined), label: 'Movies'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.trending_up_rounded), label: 'Trends'),
  ];

  int _currentTab = 1;

  final List<Widget> _tabs = [const HomeTab(),  RankingTab(), const MoviesTab(), const TrendsTab()];

  List<String> titlesAppBar = ['Home', 'Top Movies', 'Movies', 'Trends'];

  late Stream subscritionConnectivity;

  @override
  void initState() {
    super.initState();

    subscritionConnectivity =
        Connectivity().onConnectivityChanged.asBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 8, 24),
        title: Text(
          titlesAppBar[_currentTab],
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600,color: Colors.white),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {

            },
            icon: const Icon(CupertinoIcons.search),
            color: const Color.fromARGB(255, 205, 206, 209),
          )
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 7, 8, 24),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        backgroundColor: const Color.fromARGB(255, 27, 28, 42),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: const Color.fromARGB(255, 0, 124, 255),
        unselectedItemColor: Colors.white,
        items: itemsNavigationBar,
        currentIndex: _currentTab,
      ),
      body: StreamBuilder(
          stream: subscritionConnectivity,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == ConnectivityResult.mobile ||
                  snapshot.data == ConnectivityResult.wifi) {
                return _tabs[_currentTab];
              } else {
                return const Center(
                  child: Text('No internet'),
                );
              }
            } else {
              return const Center(
                child: RefreshProgressIndicator(),
              );
            }
          }),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
    //subscritionConnectivity.cancel();
  }
}
