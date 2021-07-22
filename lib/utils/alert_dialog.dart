import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String message, String text) {
  // set up the button
  Widget okButton = ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: message == 'Error' ? Colors.red : Colors.blueAccent,
    ),
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(message),
    content: Text(text),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

twoButtonsDialog(BuildContext context, func) {
  // set up the buttons
  Widget cancelButton = ElevatedButton(
    style: ElevatedButton.styleFrom(primary: Colors.red),
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = ElevatedButton(
    style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
    child: Text("Yes"),
    onPressed: func,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Delete Favorite"),
    content: Text("Are you sure you want to delete this item?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
