import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class MyBottomBar extends StatefulWidget {
  final BuildContext barContext;
  final int activeIndex;
  final dynamic switchPage;

  ///My custom ButtomBar:
  ///
  ///1-set context of current screen.
  ///
  ///2-set index 0<=x<=3 if in bottom bar or 4 if not present
  ///
  ///3-switch pages method
  ///
  const MyBottomBar(this.barContext, this.activeIndex, this.switchPage,
      {super.key});

  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  final List<String> paths = ['', 'wallet', 'categories', 'favourites'];
  void _onItemTapped(int index) {
    if (index != widget.activeIndex) {
      widget.switchPage(
        widget.barContext,
        '/${paths[index]}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 5),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(constants.borderBottom),
              topLeft: Radius.circular(constants.borderBottom),
              bottomRight: Radius.circular(constants.borderBottom),
              bottomLeft: Radius.circular(constants.borderBottom)),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: 0,
              blurRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(constants.borderBottom),
            topRight: Radius.circular(constants.borderBottom),
            bottomRight: Radius.circular(constants.borderBottom),
            bottomLeft: Radius.circular(constants.borderBottom),
          ),
          child: BottomNavigationBar(
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
            currentIndex: widget.activeIndex,
            selectedItemColor: constants.mainBackColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            onTap: _onItemTapped,
            elevation: 20,
            type: BottomNavigationBarType.shifting,
            iconSize: 30,
            selectedFontSize: 15,
            unselectedFontSize: 13,
          ),
        ),
      ),
    );
  }
}
