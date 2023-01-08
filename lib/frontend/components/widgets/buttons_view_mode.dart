import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class ViewMode extends StatefulWidget {
  final dynamic setViewMode;
  final int currMode;
  const ViewMode(this.setViewMode, this.currMode, {super.key});

  @override
  State<StatefulWidget> createState() => ViewModeState();
}

class ViewModeState extends State<ViewMode> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "View mode:",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
          IconButton(
            tooltip: "Grid",
            splashRadius: 20.0,
            iconSize: 30,
            onPressed: () => widget.setViewMode(0),
            icon: const Icon(Icons.grid_view_rounded),
            color: widget.currMode == 0
                ? constants.mainBackColor
                : constants.mainBackColor.withOpacity(0.5),
          ),
          IconButton(
            tooltip: "List",
            splashRadius: 20.0,
            iconSize: 30,
            onPressed: () => widget.setViewMode(1),
            icon: const Icon(Icons.view_list_rounded),
            color: widget.currMode == 1
                ? constants.mainBackColor
                : constants.mainBackColor.withOpacity(0.5),
          )
        ],
      ),
    );
  }
}
