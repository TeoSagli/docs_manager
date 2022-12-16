import 'package:flutter/material.dart';

import '../components/app_bar.dart';
import '../components/bottom_bar.dart';
import '../components/file_card.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Favourites", false, context),
      bottomNavigationBar: MyBottomBar(context, 3),
      body: Column(mainAxisSize: MainAxisSize.max, children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 8,
                  color: Color(0x230F1113),
                  offset: Offset(0, 4),
                )
              ],
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 8,
                  color: Color(0x230F1113),
                  offset: Offset(0, 4),
                )
              ],
              borderRadius: BorderRadius.circular(12),
              shape: BoxShape.rectangle,
            ),
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          direction: Axis.horizontal,
          runAlignment: WrapAlignment.start,
          verticalDirection: VerticalDirection.down,
          clipBehavior: Clip.none,
          children: [
            FileCard('The Running Ragamuffins', 'Fitness', '216 Members',
                'assets/images/test.png', Icons.fitness_center, 0, moveToFile),
            FileCard(
                'Dads for Gas-free Groceries',
                'Health',
                '352 Members',
                'assets/images/test.png',
                Icons.favorite_rounded,
                1,
                moveToFile),
            FileCard('My card', 'Health', '352 Members',
                'assets/images/test.png', Icons.favorite_rounded, 2, moveToFile)
          ],
        ),
      ]),
    );
  }

  moveToFile(id, context) {
    Navigator.pushNamed(
      context,
      '/files/view/$id',
    );
  }
}
