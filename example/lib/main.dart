import 'package:flutter/material.dart';
import 'package:modals/modals.dart';

import 'pages/aligned_page.dart';
import 'pages/anchor_page.dart';
import 'pages/positioned_page.dart';
import 'pages/priority_page.dart';
import 'pages/routes_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppModals',
      navigatorObservers: [modalsRouteObserver],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const _Home(),
    );
  }
}

class _Home extends StatefulWidget {
  const _Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  int _currentPage = 0;
  static const _pages = [
    PositionedPage(),
    AlignedPage(),
    AnchorPage(),
    RoutesPage(),
    PriorityPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Example'),
      ),
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.branding_watermark),
            label: 'Positioned',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.branding_watermark_sharp),
            label: 'Aligned',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.anchor),
            label: 'Anchored',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_tree_rounded),
            label: 'Routes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.low_priority),
            label: 'Priority',
          ),
        ],
        currentIndex: _currentPage,
        // selectedItemColor: Colors.amber[800],
        onTap: (index) {
          removeAllModals();
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );
  }
}
