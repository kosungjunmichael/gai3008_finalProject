import 'package:flutter/material.dart';
import '/models/transfer_model.dart';
import '/models/new_account.dart';
import '/models/balance_list.dart';
import '/models/delete_account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class hubExchange extends StatefulWidget {
  const hubExchange({Key? key}) : super(key: key);

  @override
  _hubExchangeState createState() => _hubExchangeState();
}

class _hubExchangeState extends State<hubExchange> {
  String selectedCurrency = 'USD';
  String balanceAmount = '0';
  late double totalBalance;
  //// Refresh Update
  late Timer _timer;

  bool isVButtonEnabled = true;
  bool isCaretButtonEnabled = true;
  final String user = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      setState(() {
        // Trigger a rebuild by updating the state
      });
      fetchTotalBalance();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            color: Colors.black,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.grey,
                    child: Flexible(
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const ListTile(
                              title: Row(
                                children: [
                                  Text('All accounts •'),
                                  Text('Total balance')
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Text(
                                      '\$${balanceAmount}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 25.0),
                                    ),
                                    Text('.00'),
                                  ]),
                                  Row(
                                    children: [
                                      Text(selectedCurrency),
                                      Column(
                                        children: <Widget>[
                                          TextButton(
                                            child: const Text('^'),
                                            onPressed: isCaretButtonEnabled
                                                ? () async {
                                                    setState(() {
                                                      isCaretButtonEnabled =
                                                          false;
                                                    });

                                                    double exchangeRate =
                                                        1100.0;
                                                    double usdAmount = double
                                                            .parse(
                                                                balanceAmount
                                                                    .replaceAll(
                                                                        '\$',
                                                                        '')
                                                                    .replaceAll(
                                                                        ',',
                                                                        '')) /
                                                        exchangeRate;
                                                    balanceAmount =
                                                        '${usdAmount.toStringAsFixed(2)}';

                                                    setState(() {
                                                      selectedCurrency = 'USD';
                                                    });

                                                    await Future.delayed(
                                                        Duration(seconds: 1));
                                                    setState(() {
                                                      isCaretButtonEnabled =
                                                          true;
                                                    });
                                                  }
                                                : null,
                                          ),
                                          TextButton(
                                            child: const Text('v'),
                                            onPressed: isVButtonEnabled
                                                ? () async {
                                                    setState(() {
                                                      isVButtonEnabled = false;
                                                    });

                                                    double exchangeRate =
                                                        1100.0;
                                                    double krwAmount = double
                                                            .parse(
                                                                balanceAmount
                                                                    .replaceAll(
                                                                        '\$',
                                                                        '')
                                                                    .replaceAll(
                                                                        ',',
                                                                        '')) *
                                                        exchangeRate;
                                                    balanceAmount =
                                                        '${krwAmount.toStringAsFixed(2)}';

                                                    setState(() {
                                                      selectedCurrency = 'KRW';
                                                    });

                                                    await Future.delayed(
                                                        Duration(seconds: 1));
                                                    setState(() {
                                                      isVButtonEnabled = true;
                                                    });
                                                  }
                                                : null,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          FloatingActionButton(
                            backgroundColor: Colors.black,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        transferFunds(user: user)),
                              );
                            },
                            tooltip: 'Transfer Funds',
                            child: Icon(Icons.swap_horiz),
                          ),
                          Text(
                            'Transfer Funds',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
                          ),
                        ],
                      ),
                      VerticalDivider(
                        color: Colors.black,
                        thickness: 10.0,
                      ),
                      Column(
                        children: [
                          FloatingActionButton(
                            backgroundColor: Colors.black,
                            onPressed: () {
                              // Withdraw funds
                              newAccountInput(context, user);
                            },
                            tooltip: 'Create Account',
                            child: Icon(Icons.add),
                          ),
                          Text(
                            'Create Account',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
                          ),
                        ],
                      ),
                      VerticalDivider(
                        color: Colors.black,
                        thickness: 10.0,
                      ),
                      Column(
                        children: [
                          FloatingActionButton(
                            backgroundColor: Colors.black,
                            onPressed: () {
                              // Transfer funds
                              showAccountListDialog(context, user);
                            },
                            tooltip: 'Delete Account',
                            child: Icon(Icons.remove),
                          ),
                          Text(
                            'Delete Account',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Net Worth",
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
            ),
          ),
          Flexible(child: AccountSummaryList())
        ],
      ),
    );
  }

  Future<void> fetchTotalBalance() async {
    try {
      double balance = await getTotalBalance();
      setState(() {
        totalBalance = balance;
        balanceAmount = totalBalance.toString();
      });
    } catch (error) {
      print('Error fetching total balance: $error');
    }
  }

  Future<double> getTotalBalance() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Accounts')
          .where('UID', isEqualTo: user)
          .get();

      double totalBalance = 0.0;

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        // Assuming 'balance' is an int field
        int balance = doc['balance'] ?? 0;
        totalBalance += balance.toDouble();
      }

      return totalBalance;
    } catch (error) {
      print('Error calculating total balance: $error');
      // Handle the error according to your requirements
      throw error;
    }
  }
}
