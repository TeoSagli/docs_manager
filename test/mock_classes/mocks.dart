import 'package:docs_manager/backend/create_db.dart';
import 'package:docs_manager/backend/delete_db.dart';
import 'package:docs_manager/backend/google_integration.dart';
import 'package:docs_manager/backend/models/category.dart';
import 'package:docs_manager/backend/models/file.dart';
import 'package:docs_manager/backend/operationsDB.dart';
import 'package:docs_manager/backend/read_db.dart';
import 'package:docs_manager/backend/update_db.dart';
import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/widgets/bottom_bar.dart';
import 'package:docs_manager/frontend/components/widgets/category_overview_card.dart';
import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:docs_manager/frontend/components/widgets/file_card.dart';
import 'package:docs_manager/frontend/components/widgets/list_card.dart';
import 'package:docs_manager/frontend/components/widgets/wallet_card.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:docs_manager/others/constants.dart' as constants;

FileModel fModel = FileModel(
    path: ["MyTestPath.png"],
    categoryName: "Credit Cards",
    isFavourite: true,
    dateUpload: "",
    extension: ["png"],
    expiration: "");

FileModel fModel2 = FileModel(
    path: ["MyTestPath.pdf"],
    categoryName: "Credit Cards",
    isFavourite: false,
    dateUpload: "",
    extension: ["pdf"],
    expiration: "2022-02-02");

CategoryModel cModel =
    CategoryModel(path: "", nfiles: 0, colorValue: 0, order: 0);

//======================================================================
class MockBuildContext extends Mock implements BuildContext {}

//======================================================================
class MockFileCard extends Mock implements FileCard {
  @override
  FileModel get file => fModel;
  @override
  String get fileName => "FileTest";
  @override
  StatefulElement createElement() => StatefulElement(this);
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => "";
  @override
  State<StatefulWidget> createState() => MockFileCardState();
  @override
  get delFunction => MockAlert().onDeleteFile;
}

class MockFileCardState extends State<MockFileCard> {
  @override
  Widget build(BuildContext context) {
    // return constants.emptyBox;
    return FileCard(
      "TestFile",
      fModel,
      moveToFile,
      moveToEditFilePage,
      removeCard,
      MockReadDB2().readImageFileStorage,
      MockReadDB2().getColorCategoryDB,
      MockUpdateDB().updateFavouriteDB,
      MockAlert().onDeleteFile,
    );
  }
}

//======================================================================
class MockCategoryCard extends Mock implements FileCard {
  @override
  StatefulElement createElement() => StatefulElement(this);
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => "";
  @override
  State<StatefulWidget> createState() => MockCategoryCardState();
}

class MockCategoryCardState extends State<MockCategoryCard> {
  @override
  Widget build(BuildContext context) {
    return constants.emptyBox;
  }
}

//======================================================================
class MockListCard extends Mock implements ListCard {
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => "";
  @override
  StatefulElement createElement() => StatefulElement(this);
  @override
  State<StatefulWidget> createState() => MockListCardState();
  @override
  get onDeleteFile => MockAlert().onDeleteFile;
}

class MockListCardState extends State<MockListCard> {
  @override
  Widget build(BuildContext context) {
    return ListCard(
        "TestFile",
        fModel,
        moveToFile,
        moveToEditFilePage,
        removeCard,
        MockUpdateDB().updateFavouriteDB,
        MockAlert().onDeleteFile,
        ReadDB().readImageCategoryStorage);
    // return constants.emptyBox;
  }
}

//======================================================================
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

//======================================================================
class MockWalletCard extends Mock implements WalletCard {
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => "";
  @override
  StatefulElement createElement() => StatefulElement(this);

  @override
  State<StatefulWidget> createState() => MockWalletCardState();
}

class MockWalletCardState extends State<MockWalletCard> {
  @override
  Widget build(BuildContext context) {
    return constants.emptyBox;
  }
}

//======================================================================
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

//======================================================================
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

//======================================================================
class MockDrawer extends Mock implements MyDrawer {
  @override
  StatelessElement createElement() => StatelessElement(this);
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => "";
  @override
  Widget build(BuildContext context) {
    return MyDrawer(alert);
  }
}

//======================================================================
class MockAlert extends Mock implements Alert {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => "";
  @override
  openCalendar(context, onDateSelected, onDateUnselected) {
    onDateUnselected(context);
    onDateSelected(DateTime.now(), context);
  }

  @override
  navigateTo(path, context) {}
  @override
  navigateBack(context) {}
  @override
  onErrorImage(context) {}
  @override
  onErrorText(context) {}
  @override
  onErrorElementExisting(context, String elName) {}
  @override
  onErrorFileExisting(context) {}
  @override
  onSuccess(context, path) {}
  @override
  onLoginConfirmed(context, path) {}
  @override
  onRegistrationConfirmed(context, path) {}
  @override
  onErrorFirebase(context, e) {}
  @override
  onErrorGeneric(context, e) {}
  @override
  onGeneric(context, message) {}
  @override
  onDateConfirmed(context, message) {}
  @override
  onDateUnconfirmed(context) {}
  @override
  onDelete(context, deleteCategory, card, path) {}
  @override
  onDeleteFile(context, deleteFile, card) {
    deleteFile(card);
  }

  @override
  onLoad(context) {}
  @override
  onSettings(context) {}
  @override
  onAccountStatus(context) {}
}

//======================================================================
class MockOperationsDB extends Mock implements OperationsDB {
  MockOperationsDB();
  @override
  MockReadDB get readDB => MockReadDB();
  @override
  MockCreateDB get createDB => MockCreateDB();
  @override
  MockUpdateDB get updateDB => MockUpdateDB();
  @override
  MockDeleteDB get deleteDB => MockDeleteDB();
}

//======================================================================
class MockReadDB extends Mock implements ReadDB {
  @override
  retrieveFileDataFromFileNameDB(String fileName, dynamic setFileData) {
    setFileData(fModel2);
  }

  @override
  retrieveFilesFromCategoryDB(catName, fulfillCard, moveToFile, moveToEditFile,
      removeFileCard, context) {
    List<Widget> myCards = [];
    List<Widget> myCardsList = [];
    fulfillCard(myCards, myCardsList);
  }

  @override
  readImageFileStorage(
    int i,
    String catName,
    String fileName,
    String ext,
    Widget cardImage,
    BuildContext context,
    bool isFullHeigth,
    dynamic setImage,
  ) {
    setImage(Image.asset(
      "assets/images/No_docs.png",
    ));
  }

  @override
  getColorCategoryDB(dynamic setColor, String catName) {
    setColor(4282682111);
  }

  @override
  retrieveAllFilesDB(
      fulfillFileCards, moveToFile, moveToEditFile, removeFileCard, e) {
    List<Widget> myCardsGrid = [];
    List<Widget> myCardsList = [];
    /*  TODO
  MockAlert().onDeleteFile(MockBuildContext(), removeFileCard, MockFileCard());*/
    fulfillFileCards(myCardsGrid, myCardsList);
  }
}

//======================================================================
class MockReadDB2 extends Mock implements ReadDB {
  @override
  retrieveFileDataFromFileNameDB(String fileName, dynamic setFileData) {
    setFileData(fModel2);
  }

  @override
  retrieveFilesFromCategoryDB(catName, fulfillCard, moveToFile, moveToEditFile,
      removeFileCard, context) {
    moveToFile("", context);
    moveToEditFile("", context);
    List<Widget> myCards = [MockFileCard()];
    List<Widget> myCardsList = [MockFileCard()];
    fulfillCard(myCards, myCardsList);
  }

  @override
  retrieveAllFilesDB(
      fulfillFileCards, moveToFile, moveToEditFile, removeFileCard, e) {
    List<Widget> myCardsGrid = [MockFileCard()];
    List<Widget> myCardsList = [MockListCard()];
    fulfillFileCards(myCardsGrid, myCardsList);
    moveToFile("test", MockBuildContext());
    moveToEditFile("test", MockBuildContext());
  }

  @override
  retrieveCategoryOverviewDB(fulfillCategoriesCards, moveToCategory) {
    List<Container> myCards = [];
    List<int> myOrders = [];
    myCards.add(Container(child: MockCategoryOverviewCard()));
    myOrders.add(0);
    moveToCategory("test", MockBuildContext());
    fulfillCategoriesCards(myCards, myOrders);
  }
}

//======================================================================
class MockCreateDB extends Mock implements CreateDB {}

//======================================================================
class MockUpdateDB extends Mock implements UpdateDB {
  @override
  updateOrderDB(int index, String catName) {}
  @override
  updateFavouriteDB(String catName, String fileName, bool value) {}
  @override
  onUpdateNFilesDB(String catName) {}
  @override
  updateCategoryDB(String catName, CategoryModel cat) {}
  @override
  updateUserLogutStatus(context) {}
}

//======================================================================
class MockDeleteDB extends Mock implements DeleteDB {
  @override
  deleteCategoryDB(String catName) {}
  @override
  deleteCategoryStorage(String catPath, String catName) {}
  @override
  deleteFileDB(String catName, String fileName) {}
  @override
  deleteFileStorage(List<Object?> ext, String catName, String fileName) {}
}

//======================================================================
class MockGoogle extends Mock implements GoogleManager {
  @override
  dynamic upload(FileModel file, String fileName) {
    return AlertMessage(true, "Upload completed!");
  }

  @override
  dynamic addCalendarExpiration(
      FileModel file, String fileName, String expiration) {
    return AlertMessage(true, "Upload completed!");
  }

  @override
  removeCalendarExpiration(String fileName) {
    return AlertMessage(true, "Upload completed!");
  }
}

//======================================================================
//File Card
moveToFile(a, b) {}
moveToEditFilePage(a, b) {}
removeCard(card) {}

//======================
updateUserLogutStatus() {}
onAccountStatus() {}
onSettings() {}
navigateTo() {}
//==================
moveToCategory() {}
readImageCategoryStorage() {}
//==================
