import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String mainTitle;
  final String subTitle1;
  final String subTitle2;
  final Image image;
  final Color color;
  final int id;
  final dynamic function;

  const CategoryCard(this.mainTitle, this.subTitle1, this.subTitle2, this.image,
      this.color, this.id, this.function,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 3,
              color: Color(0x25000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: GestureDetector(
          onTap: () => function(id, context),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 5, 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 4, 8),
                  child: Container(
                    width: 4,
                    height: 90,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 16, 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mainTitle,
                        style: const TextStyle(
                          fontFamily: 'Outfit',
                          color: Color(0xFF101213),
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          subTitle1,
                          style: const TextStyle(
                            fontFamily: 'Outfit',
                            color: Color(0xFF57636C),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          subTitle2,
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            color: color,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    'assets/images/test.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
