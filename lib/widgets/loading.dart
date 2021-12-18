import 'package:flutter/material.dart';

import '../constants.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text(
            Constants.loadingText,
            style: TextStyle(fontSize: 20, color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }
}
