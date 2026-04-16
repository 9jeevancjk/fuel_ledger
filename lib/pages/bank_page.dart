import 'package:flutter/material.dart';

class BankPage extends StatefulWidget {
  const BankPage({super.key});

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsetsGeometry.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: 0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: () {}, child: Text('Button')),
                    ElevatedButton(onPressed: () {}, child: Text('Button')),
                  ],
                ),
                Card(
                  elevation: 8,
                  shadowColor: Colors.grey,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.78,
                    child: Center(child: Text('Bank Page')),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
