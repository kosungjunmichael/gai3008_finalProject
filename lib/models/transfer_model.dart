import 'package:flutter/material.dart';

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
    return Container(
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
      ),
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
  String selectedWithdrawAccount = 'Account 1';
  String selectedDepositAccount = 'Account A';

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
                DropdownButton<String>(
                  value: selectedWithdrawAccount,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedWithdrawAccount = newValue!;
                    });
                  },
                  items: <String>['Account 1', 'Account2', 'Account3']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  value: selectedDepositAccount,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDepositAccount = newValue!;
                    });
                  },
                  items: <String>['Account A', 'Account B', 'Account C']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
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
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            content: Text(
                              "You have deposited: ${_myController.text} USD",
                              style: const TextStyle(fontSize: 30),
                            ),
                          ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
