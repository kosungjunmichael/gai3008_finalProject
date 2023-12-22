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
          // Group accounts by type
          Map<String, List<DocumentSnapshot>> groupedAccounts = {};
          snapshot.data!.docs.forEach((doc) {
            String type = doc['type'];
            if (!groupedAccounts.containsKey(type)) {
              groupedAccounts[type] = [];
            }
            groupedAccounts[type]!.add(doc);
          });

          // Create a list of ListTile widgets for each type
          List<Widget> listTiles = groupedAccounts.keys.map((type) {
            List<DocumentSnapshot> accounts = groupedAccounts[type]!;
            int numberOfAccounts = accounts.length;
            double totalBalance = accounts
                .map((doc) => double.parse(doc['balance'].toString()))
                .fold(0, (sum, balance) => sum + balance);

            return ListTile(
              title: Text('$type Accounts'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Number of Accounts: $numberOfAccounts'),
                  Text('Total Balance: \$${totalBalance.toStringAsFixed(2)}'),
                ],
              ),
            );
          }).toList();

          // Return a ListView with the generated list of ListTile widgets
          return ListView(
            children: listTiles,
          );
        }
      },
    );
  }
}
