import 'package:flutter/material.dart';

import 'abstract/card.dart';

class FileCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FileCardState();
  final String path;
  final IconData icon;
  final String mainTitle;
  final String subTitle1;
  final String subTitle2;
  final int id;
  final dynamic function;

  const FileCard(this.mainTitle, this.subTitle1, this.subTitle2, this.path,
      this.icon, this.id, this.function,
      {super.key});
}

class FileCardState extends State<FileCard> with MyCard {
  @override
  onExitHover() {
    setState(() {
      cardColor = Colors.white;
    });
  }

  @override
  onHover() {
    setState(() {
      cardColor = Colors.white30;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
      child: MouseRegion(
        onEnter: ((event) => onHover()),
        onExit: ((event) => onExitHover()),
        child: GestureDetector(
          onTap: () => widget.function(widget.id, context),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.45,
            decoration: BoxDecoration(
              color: cardColor,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 3,
                  color: Color(0x25000000),
                  offset: Offset(0, 2),
                )
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        widget.path,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                        child: Icon(
                          widget.icon,
                          color: const Color(0xFF57636C),
                          size: 24,
                        ),
                      ),
                      Text(
                        widget.subTitle1,
                        style: const TextStyle(
                          fontFamily: 'Outfit',
                          color: Color(0xFF57636C),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                    child: Text(
                      widget.mainTitle,
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 0, 0),
                    child: Text(
                      widget.subTitle2,
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        color: Color(0xFF57636C),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
