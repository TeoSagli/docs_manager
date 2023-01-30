import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class Alert {
//========================================================
  ///Alert structure
  mySnackbarTemplate(context, textToShow) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsetsDirectional.all(20),
        duration: const Duration(milliseconds: constants.alertDurAnimation),
        content: Text(textToShow),
      ),
    );
  }

  ///Alert if pushNamed
  myAlertPushNamed(context, path, textToShow) {
    mySnackbarTemplate(context, textToShow);
    Navigator.pushNamed(context, path);
  }

  ///Alert if pop
  myAlertPop(context, textToShow) {
    mySnackbarTemplate(context, textToShow);
  }

//========================================================

  ///Alert error during image upload
  onErrorImage(context) {
    myAlertPop(context, "Something went wrong: a document is required!");
  }

//========================================================
  ///Alert error during text fill
  onErrorText(context) {
    myAlertPop(
        context, "Something went wrong: text cannot contain '.' or be empty !");
  }

//========================================================
  ///Alert error element already existing
  onErrorElementExisting(context, String elName) {
    myAlertPop(context, "Something went wrong: $elName already existing!");
  }

//========================================================
  ///Alert error category already existing
  onErrorFileExisting(context) {
    myAlertPop(context, "Something went wrong: File already existing!");
  }

//========================================================
  ///Alert success submit
  onSuccess(context, path) {
    myAlertPushNamed(context, path, 'Operation confirmed!');
  }

//========================================================
  ///Alert success submit
  onSuccessCalendar(context, path) {
    myAlertPushNamed(context, path, 'Event added to Google Calendar!');
  }

  //========================================================
  ///Alert success submit
  onSuccessDrive(context, path) {
    myAlertPushNamed(context, path, 'Event added to Google Drive!');
  }

  //========================================================
  ///Alert success submit
  onSuccessRemoveCalendar(context, path) {
    myAlertPushNamed(context, path, 'Event removed from Google Calendar!');
  }

//========================================================
  ///Alert login confirmed
  onLoginConfirmed(context, path) {
    myAlertPushNamed(
        context, path, 'Login Confirmed. Welcome back in DocuManager!');
  }

//========================================================
  ///Alert registration confirmed
  onRegistrationConfirmed(context, path) {
    myAlertPushNamed(context, path,
        'Registration Confirmed. Login with your credentials now!');
  }

//========================================================
  ///Alert error firebase
  onErrorFirebase(context, e) {
    myAlertPop(context, "Something went wrong: ${e.message.toString()}");
  }

//========================================================
  ///Alert error generic
  onErrorGeneric(context, e) {
    myAlertPop(context, "Something went wrong: ${e.toString()}");
  }

//========================================================
  ///Alert success submit
  onGeneric(context, message) {
    myAlertPop(context, message);
  }

//===================================================================================
  /// Alert date submitted
  onDateConfirmed(dateText, context) {
    myAlertPop(context, 'Selection Confirmed: $dateText');
    Navigator.pop(context);
  }

//===================================================================================
  /// Alert date input cleared
  onDateUnconfirmed(context) {
    myAlertPop(context, 'Input cleared');
    Navigator.pop(context);
  }

//===================================================================================
  /// Open calendar view
  openCalendar(context, onDateSelected, onDateUnselected) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Pick an expiration date'),
        content: SizedBox(
            height: MediaQuery.of(context).size.width * 0.9,
            width: MediaQuery.of(context).size.width * 0.6,
            child: SfDateRangePicker(
              minDate: DateTime.now(),
              view: DateRangePickerView.decade,
              selectionMode: DateRangePickerSelectionMode.single,
              showActionButtons: true,
              cancelText: 'CANCEL',
              confirmText: 'OK',
              onSubmit: (value) {
                if (value != null) {
                  onDateSelected(value as DateTime, context);
                }
              },
              onCancel: () => onDateUnselected(context),
            )),
      ),
    );
  }

//========================================================
  ///Alert delete category
  onDelete(context, deleteCategory, card, path) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete this category?'),
        content: const Text(
            'You are permanently deleting this category and all files contained in it. Do you confirm?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              deleteCategory(card);
              Navigator.pushNamed(context, path);
            },
            child: const Text(
              'Yes, delete this category',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

//========================================================
  ///Alert delete file
  onDeleteFile(context, deleteFile, card) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete this file?'),
        content: const Text(
            'You are permanently deleting this file. Do you confirm?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              deleteFile(card);
              Navigator.pushNamed(context, "/");
            },
            child: const Text(
              'Yes, delete this file',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

//========================================================
  ///Loading status
  onLoad(context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => const AbsorbPointer(
        absorbing: true,
        child: AlertDialog(
          title: Text('Processing'),
          content: constants.loadingWheel,
        ),
      ),
    );
  }

//========================================================
  ///Load app settings
  onSettings(context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: const Text('Settings'),
          content: constants.emptyBox,
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Back',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ]),
    );
  }

//========================================================
  ///Simple navigation psuh
  navigateTo(String path, BuildContext context) {
    Navigator.pushNamed(context, path);
  }

//========================================================
  ///Simple navigation pop
  navigateBack(context) {
    Navigator.pop(context);
  }

//========================================================
  ///Load user information
  onAccountStatus(context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: const Text('Profile information'),
          content:
              Text("Logged in as ${FirebaseAuth.instance.currentUser!.email!}"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Back',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ]),
    );
  }
//===================================================================================
}
