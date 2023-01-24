import 'package:docs_manager/backend/models/category.dart';
import 'package:docs_manager/backend/models/file.dart';
import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/widgets/bottom_bar.dart';
import 'package:docs_manager/frontend/components/widgets/category_overview_card.dart';
import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:docs_manager/frontend/components/widgets/file_card.dart';
import 'package:docs_manager/frontend/components/widgets/list_card.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:docs_manager/others/constants.dart' as constants;

FileModel fModel = FileModel(
    path: ["MyTestPath.png"],
    categoryName: "MyTestCat",
    isFavourite: false,
    dateUpload: "",
    extension: ["png"],
    expiration: "");

CategoryModel cModel =
    CategoryModel(path: "", nfiles: 0, colorValue: 0, order: 0);

//======================================================================
class MockBuildContext extends Mock implements BuildContext {}

class MockFileCard extends Mock implements FileCard {
  @override
  StatefulElement createElement() => StatefulElement(this);
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => "";
  @override
  State<StatefulWidget> createState() => MockFileCardState();
}

class MockFileCardState extends State<MockFileCard> {
  @override
  Widget build(BuildContext context) {
    return constants.emptyBox;
  }
}

class MockListCard extends Mock implements ListCard {
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => "";
  @override
  StatefulElement createElement() => StatefulElement(this);
  @override
  State<StatefulWidget> createState() => MockListCardState();
}

class MockListCardState extends State<MockListCard> {
  @override
  Widget build(BuildContext context) {
    return constants.emptyBox;
  }
}

class MockCategoryOverviewCard extends Mock implements CategoryOverviewCard {
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => "";
  @override
  StatefulElement createElement() => StatefulElement(this);

  @override
  State<StatefulWidget> createState() => MockCategoryOverviewCardState();
}

class MockCategoryOverviewCardState extends State<MockCategoryOverviewCard> {
  @override
  Widget build(BuildContext context) {
    return constants.emptyBox;
  }
}

class MockAppBar extends Mock implements MyAppBar {
  @override
  Size get preferredSize => const Size(100, 100);
  @override
  StatelessElement createElement() => StatelessElement(this);
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => "";
  @override
  Widget build(BuildContext context) {
    return MyAppBar('Register', true, context, false, Navigator.pop, navigateTo,
        updateUserLogutStatus);
  }
}

class MockBottomBar extends Mock implements MyBottomBar {
  @override
  StatefulElement createElement() => StatefulElement(this);
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => "";
  @override
  State<MyBottomBar> createState() => MockBottomBarState();
}

class MockBottomBarState extends State<MockBottomBar> {
  @override
  Widget build(BuildContext context) {
    return MyBottomBar(context, 0, navigateTo);
  }
}

class MockDrawer extends Mock implements MyDrawer {
  @override
  StatelessElement createElement() => StatelessElement(this);
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => "";
  @override
  Widget build(BuildContext context) {
    return const MyDrawer(onAccountStatus, onSettings);
  }
}

//===============
//File Card
void method1(fileName, context) {}
void updateFavouriteDB(categoryName, fileName, isFav) {}
void moveToEditFilePage(fileName, context) {}
void removeCard(el) {}
void onDeleteFile(context, removeCard, widget) {}
void initColorFromDB(setColor, categoryName) {
  setColor(4282682111);
}

//======================
updateUserLogutStatus() {}
onAccountStatus() {}
onSettings() {}
navigateTo() {}
//==================
moveToCategory() {}
readImageCategoryStorage() {}
//==================
function() {}
