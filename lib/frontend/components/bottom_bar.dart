import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class MyBottomBar extends StatefulWidget {
  final BuildContext barContext;
  final int activeIndex;

  ///My custom ButtomBar:
  ///
  ///1-set context of current screen.
  ///
  ///2-set index 0<=x<=3 if in bottom bar or 4 if not present
  ///
  const MyBottomBar(this.barContext, this.activeIndex, {super.key});

  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  final List<String> paths = ['', 'wallet', 'categories', 'favourites'];
  void _onItemTapped(int index) {
    Navigator.pushNamed(
      widget.barContext,
      '/${paths[index]}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
          activeIcon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet_outlined),
          label: 'Wallet',
          activeIcon: Icon(Icons.account_balance_wallet_rounded),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          label: 'Categories',
          activeIcon: Icon(Icons.category),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline_rounded),
          label: 'Favourites',
          activeIcon: Icon(Icons.favorite),
        ),
      ],
      currentIndex: widget.activeIndex < 4 ? widget.activeIndex : 0,
      selectedItemColor:
          widget.activeIndex < 4 ? constants.mainBackColor : Colors.grey,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      onTap: _onItemTapped,
    );
  }
}
