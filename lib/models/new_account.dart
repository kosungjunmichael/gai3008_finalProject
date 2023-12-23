import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const List<String> accountTypeValue = ['Personal', 'Savings', 'Crypto'];

class MyDialogWidget extends StatefulWidget {
  final String user;

  MyDialogWidget({required this.user});

  @override
  _MyDialogWidgetState createState() => _MyDialogWidgetState();
}

class _MyDialogWidgetState extends State<MyDialogWidget> {
  String accountType = 'Personal';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController numberController = TextEditingController();
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create New Account'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButton<String>(
            value: accountType,
            onChanged: (String? newValue) {
              setState(() {
                accountType = newValue!;
              });
            },
            items: accountTypeValue.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            selectedItemBuilder: (BuildContext context) {
              return accountTypeValue.map<Widget>((String value) {
                return Text(accountType);
              }).toList();
            },
          ),
          TextField(
            controller: numberController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Enter Balance'),
          ),
          TextField(
            controller: textController,
            decoration: InputDecoration(labelText: 'Enter Account Name'),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            int? intValue = int.tryParse(numberController.text);

            _firestore.collection('Accounts').add({
              'UID': widget.user,
              'accountName': textController.text,
              'balance': intValue,
              'type': accountType,
            });
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}

Future<void> newAccountInput(BuildContext context, String user) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return MyDialogWidget(user: user);
    },
  );
}
