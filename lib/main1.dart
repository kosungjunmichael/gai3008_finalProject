import 'package:flutter/material.dart';
import 'pages/hub_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            flexibleSpace: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        child: Text('Hello, Tim',
                            style: TextStyle(
                                color: Colors.white, fontSize: 25.0))),
                    Container(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Image.network(
                          'https://images.creativemarket.com/0.1.0/ps/1895597/1360/2166/m1/fpnw/wm1/wvgshco03n8e1avxqhpzuuxcukykfue1jlfdmgda5vxwatqgxe5ircqstmn7cv25-.jpg?1479174239&s=09b85f2cd288ebac54ced98a5083ed53',
                          width: 60,
                          height: 60,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Hub'),
                Tab(text: 'Cash'),
                Tab(text: 'Crypto'),
              ],
            ),
          ),
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            indicatorColor: Colors.amber[800],
            selectedIndex: currentPageIndex,
            destinations: const <Widget>[
              NavigationDestination(
                selectedIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: '',
              ),
              NavigationDestination(
                icon: Icon(Icons.inventory),
                label: '',
              ),
              NavigationDestination(
                icon: Icon(Icons.sync_alt),
                label: '',
              ),
              NavigationDestination(
                icon: Icon(Icons.heart_broken),
                label: '',
              ),
              NavigationDestination(
                icon: Icon(Icons.compass_calibration),
                label: '',
              ),
            ],
          ),
          body: <Widget>[
            TabBarView(
              children: [
                Container(
                  child: hubExchange(),
                ),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_bike),
              ],
            ),
            Container(
              color: Colors.green,
              alignment: Alignment.center,
              child: const Text('Page 2'),
            ),
            Container(
              color: Colors.blue,
              alignment: Alignment.center,
              child: const Text('Page 3'),
            ),
            Container(
              color: Colors.blue,
              alignment: Alignment.center,
              child: const Text('Page 4'),
            ),
            Container(
              color: Colors.blue,
              alignment: Alignment.center,
              child: const Text('Page 5'),
            ),
          ][currentPageIndex],
        ),
      ),
    );
  }
}



  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<void> fetchData() async {
  //   try {
  //     DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //         .collection('User')
  //         .doc('jzgLfUQOExuMh8DjpSTD')
  //         .get();

  //     if (snapshot.exists) {
  //       // Access the 'crypto' field from the document
  //       var cryptoValue = snapshot['crypto'];
  //       print('Crypto Value: $cryptoValue');
  //     } else {
  //       print('Document does not exist');
  //     }
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //   }
  // }



      // CollectionReference reservations = _firestore.collection('User');

    // final docRef = reservations.doc();
    // docRef.get().then(
    //   (DocumentSnapshot doc) {
    //     final data = doc.data() as Map<String, dynamic>;
    //     print(data);
    //   },
    //   onError: (e) => print("Error getting document: $e"),
    // );