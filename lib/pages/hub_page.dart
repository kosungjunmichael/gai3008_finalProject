import 'package:flutter/material.dart';
import '/models/transfer_model.dart';

final List<Map<String, String>> netMap = [
  {
    'name': 'Cash Balance',
    'sub': '8 accounts',
    'amount': "\$23,000,00",
    'CPO': "99%",
    'image': 'https://cdn-icons-png.flaticon.com/512/2878/2878574.png',
  },
  {
    'name': 'Savings',
    'sub': 'Savings',
    'amount': "\$128,375",
    'CPO': "<10%",
    'image':
        'https://png.pngtree.com/png-vector/20190320/ourlarge/pngtree-vector-vault-icon-png-image_850794.jpg',
  },
  {
    'name': 'Crypto',
    'sub': '2 currencies',
    'amount': "\$28,182",
    'CPO': "50%",
    'image': 'https://cryptologos.cc/logos/chainlink-link-logo.png',
  },
];

class hubExchange extends StatelessWidget {
  const hubExchange({super.key});

  final int total = 2456557;

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
                                  Row(
                                    children: [
                                      Text('\$${total}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25.0)),
                                      Text('.00'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('USD'),
                                      Column(
                                        children: <Widget>[
                                          TextButton(
                                            child: const Text('^'),
                                            onPressed: () {},
                                          ),
                                          TextButton(
                                            child: const Text('v'),
                                            onPressed: () {},
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
                                    builder: (context) => transferFunds()),
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
          Flexible(
            child: ListView.builder(
              itemCount: netMap.length,
              itemBuilder: (context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(netMap[index]['image']!),
                    backgroundColor: Colors.white,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(netMap[index]['name']!),
                      Text(netMap[index]['amount']!),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(netMap[index]['sub']!),
                      Text(netMap[index]['CPO']!)
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
