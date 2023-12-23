import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NumPad extends StatelessWidget {
  final double buttonSize;
  final Color buttonColor;
  final Color iconColor;
  final TextEditingController controller;
  final Function delete;
  final Function onSubmit;

  const NumPad({
    Key? key,
    this.buttonSize = 40,
    this.buttonColor = Colors.transparent,
    this.iconColor = Colors.black,
    required this.delete,
    required this.onSubmit,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberButton(
                  number: 1,
                  size: buttonSize,
                  color: buttonColor,
                  controller: controller,
                ),
                NumberButton(
                  number: 2,
                  size: buttonSize,
                  color: buttonColor,
                  controller: controller,
                ),
                NumberButton(
                  number: 3,
                  size: buttonSize,
                  color: buttonColor,
                  controller: controller,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberButton(
                  number: 4,
                  size: buttonSize,
                  color: buttonColor,
                  controller: controller,
                ),
                NumberButton(
                  number: 5,
                  size: buttonSize,
                  color: buttonColor,
                  controller: controller,
                ),
                NumberButton(
                  number: 6,
                  size: buttonSize,
                  color: buttonColor,
                  controller: controller,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberButton(
                  number: 7,
                  size: buttonSize,
                  color: buttonColor,
                  controller: controller,
                ),
                NumberButton(
                  number: 8,
                  size: buttonSize,
                  color: buttonColor,
                  controller: controller,
                ),
                NumberButton(
                  number: 9,
                  size: buttonSize,
                  color: buttonColor,
                  controller: controller,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => delete(),
                  icon: Icon(
                    Icons.backspace,
                    color: iconColor,
                  ),
                  iconSize: buttonSize,
                ),
                NumberButton(
                  number: 0,
                  size: buttonSize,
                  color: buttonColor,
                  controller: controller,
                ),
                IconButton(
                  onPressed: () => onSubmit(),
                  icon: Icon(
                    Icons.done_rounded,
                    color: iconColor,
                  ),
                  iconSize: buttonSize,
                ),
              ],
            ),
          ],
        ),
      ),)
    );
  }
}

class NumberButton extends StatelessWidget {
  final int number;
  final double size;
  final Color color;
  final TextEditingController controller;

  const NumberButton({
    Key? key,
    required this.number,
    required this.size,
    required this.color,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(size * 0.2),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size / 2),
          ),
        ),
        onPressed: () {
          controller.text += number.toString();
        },
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class transferFunds extends StatefulWidget {
  final String user;

  transferFunds({required this.user});

  @override
  _transferFundsState createState() => _transferFundsState();
}

class _transferFundsState extends State<transferFunds> {
  final TextEditingController _myController = TextEditingController();
  String? selectedWithdrawAccount;
  String? selectedDepositAccount;

  @override
  void initState() {
    super.initState();
    // Call your asynchronous data retrieval function here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 132, 255, 169),
        title: Center(
            child: const Text('Transfer Funds',
                style: TextStyle(color: Colors.black, fontSize: 25.0))),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FutureBuilder<List<String>>(
                  future: getAccountNames(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<String>> snapshot) {
                    if (snapshot.hasData) {
                      return DropdownButton<String>(
                        hint: Text('Withdraw'),
                        value: selectedWithdrawAccount,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedWithdrawAccount = newValue!;
                          });
                        },
                        items: snapshot.data!
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    return CircularProgressIndicator(); // You can return any widget you'd like here before the data is loaded
                  },
                ),
                FutureBuilder<List<String>>(
                  future: getAccountNames(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<String>> snapshot) {
                    if (snapshot.hasData) {
                      return DropdownButton<String>(
                        hint: Text('Deposit'),
                        value: selectedDepositAccount,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDepositAccount = newValue!;
                          });
                        },
                        items: snapshot.data!
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    return CircularProgressIndicator(); // You can return any widget you'd like here before the data is loaded
                  },
                ),
              ],
            ),
            Container(
              color: Color.fromARGB(255, 132, 255, 169),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: 35,
                  child: Center(
                      child: TextField(
                    controller: _myController,
                    textAlign: TextAlign.center,
                    showCursor: false,
                    style: const TextStyle(fontSize: 40),
                    keyboardType: TextInputType.none,
                  )),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: NumPad(
                buttonSize: 75,
                controller: _myController,
                delete: () {
                  _myController.text = _myController.text
                      .substring(0, _myController.text.length - 1);
                },
                onSubmit: () {
                  debugPrint('You have deposited: ${_myController.text} USD');

                  final double transferValue = double.parse(_myController.text);
                  print(selectedDepositAccount);
                  transferFunds(selectedWithdrawAccount, selectedDepositAccount,
                      transferValue);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<String>> getAccountNames() async {
    List<String> accountNames = [];
    final accounts = await FirebaseFirestore.instance
        .collection('Accounts')
        .where('UID', isEqualTo: widget.user)
        .get();
    for (var document in accounts.docs) {
      accountNames.add(document['accountName']);
    }
    return accountNames;
  }

  Future<void> transferFunds(
      String? withdrawAcc, String? despositAcc, double amountToTransfer) async {
    final withdrawID = await FirebaseFirestore.instance
        .collection('Accounts')
        .where('UID', isEqualTo: widget.user)
        .where('accountName', isEqualTo: withdrawAcc)
        .get();
    final depositID = await FirebaseFirestore.instance
        .collection('Accounts')
        .where('UID', isEqualTo: widget.user)
        .where('accountName', isEqualTo: despositAcc)
        .get();

    try {
      final withdrawDocumentId = withdrawID.docs[0].id;
      // Subtract from the source account
      await FirebaseFirestore.instance
          .collection('Accounts')
          .doc(withdrawID.docs[0].id)
          .update({
        'balance': FieldValue.increment(-amountToTransfer),
      });

      // Add to the destination account
      await FirebaseFirestore.instance
          .collection('Accounts')
          .doc(depositID.docs[0].id)
          .update({
        'balance': FieldValue.increment(amountToTransfer),
      });

      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text(
                  "You have deposited: ${amountToTransfer} USD",
                  style: const TextStyle(fontSize: 30),
                ),
              ));
    } catch (error) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text(
                  "There was an error transfering the funds",
                  style: const TextStyle(fontSize: 30),
                ),
              ));
    }
  }
}
