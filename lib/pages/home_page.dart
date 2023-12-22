import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'hub_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))
      ]),
      body:
          // Center(child: Text("LOGGED IN AS: ${user.email}"))
          const MyHomePage(),
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
  final user = FirebaseAuth.instance.currentUser!;

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
                        child: Text('Hello, ${user.email}',
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
