import 'package:docs_manager/frontend/components/app_bar.dart';
import 'package:docs_manager/frontend/components/button_add.dart';
import 'package:flutter/material.dart';

import '../../components/bottom_bar.dart';
import '../../components/category_card.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("All categories", true, context),
      bottomNavigationBar: MyBottomBar(context, 2),
      body: Stack(children: [
        ListView(
          padding: EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            CategoryCard(
                'IDs',
                '4 Elements',
                '3 upcoming due dates',
                Image.network(
                  'https://www.cuzzola.it/wp-content/uploads/2020/07/arton69839-e1595494383710.jpg',
                ),
                const Color(0xFF4B39EF),
                0,
                moveToCategory),
            CategoryCard(
                'Credit cards',
                '5 Elements',
                '3 upcoming due dates',
                Image.network(
                  'https://cartadicreditoconfronto.it/images/product/carta-credito-chebanca-mastercard.png',
                ),
                Colors.greenAccent,
                1,
                moveToCategory),
            CategoryCard(
                'Other cards',
                '3 Elements',
                '3 upcoming due dates',
                Image.network(
                  'https://media-assets.wired.it/photos/615ea7ed5ccc3b73fb14c3b0/master/w_1600,c_limit/1431618247_carta_tessera.jpg',
                ),
                Colors.orangeAccent,
                2,
                moveToCategory),
            CategoryCard(
                'Pictures',
                '1 Elements',
                '3 upcoming due dates',
                Image.network(
                    'https://cdn-icons-png.flaticon.com/512/223/223117.png'),
                Colors.redAccent,
                3,
                moveToCategory)
          ],
        ),
        ButtonAdd(context, '/categories/create')
      ]),
    );
  }

  moveToCategory(id, context) {
    Navigator.pushNamed(
      context,
      '/categories/view/$id',
    );
  }
}