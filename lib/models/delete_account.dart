import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountListDialog extends StatefulWidget {
  final String user;

  AccountListDialog({required this.user});

  @override
  _AccountListDialogState createState() => _AccountListDialogState();
}

class _AccountListDialogState extends State<AccountListDialog> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Future<QuerySnapshot> _accountsFuture;

  @override
  void initState() {
    super.initState();
    _refreshAccounts();
  }

  Future<void> _refreshAccounts() async {
    setState(() {
      _accountsFuture = _firestore
          .collection('Accounts')
          .where('UID', isEqualTo: widget.user)
          .get();
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(_accountsFuture.docs[0].id);
    return AlertDialog(
      title: Text('Account List'),
      content: FutureBuilder<QuerySnapshot>(
        future: _accountsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('No accounts found.');
          } else {
            // Display the list of accounts with delete buttons
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: snapshot.data!.docs.map((doc) {
                return ListTile(
                  title: Text(doc['accountName']),
                  subtitle: Column(
                    children: [
                      Text('Type: ${doc['type']}'),
                      Text(' Balance: ${doc['balance']}')
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteAccount(doc.id);
                    },
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }

  // Function to delete an account document
  void _deleteAccount(String documentId) {
    _firestore.collection('Accounts').doc(documentId).delete().then((_) {
      _refreshAccounts();
    }).catchError((error) {
      // Handle errors, show a message, etc.
      print('Error deleting account: $error');
    });
  }
}

Future<void> showAccountListDialog(BuildContext context, String user) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AccountListDialog(user: user);
    },
  );
}
