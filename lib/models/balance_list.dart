import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountSummaryList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('Accounts').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No accounts found.');
        } else {
          Map<String, List<DocumentSnapshot>> groupedAccounts = {};
          snapshot.data!.docs.forEach((doc) {
            String type = doc['type'];
            if (!groupedAccounts.containsKey(type)) {
              groupedAccounts[type] = [];
            }
            groupedAccounts[type]!.add(doc);
          });

          List<Widget> listTiles = groupedAccounts.keys.map((type) {
            List<DocumentSnapshot> accounts = groupedAccounts[type]!;
            int numberOfAccounts = accounts.length;
            double totalBalance = accounts
                .map((doc) => double.parse(doc['balance'].toString()))
                .fold(0, (sum, balance) => sum + balance);

            String imagePath = 'lib/images/';
            if (type == 'Personal') {
              imagePath += 'CashBalance.png';
            } else if (type == 'Savings') {
              imagePath += 'Savings.jpg';
            } else if (type == 'Crypto') {
              imagePath += 'Crypto.png';
            }            

            return ListTile(
              title: Text('$type Accounts'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Number of Accounts: $numberOfAccounts'),
                  Text('Total Balance: \$${totalBalance.toStringAsFixed(2)}'),
                ],
              ),
              leading: Image.asset(
                imagePath,
                width: 50,
                height: 50,
              ),
            );
          }).toList();

          return ListView(
            children: listTiles,
          );
        }
      },
    );
  }
}