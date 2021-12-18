import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Colors.black45),
        const SizedBox(height: 20),
        Text(
          Constants.requirementsText_1,
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: MediaQuery.of(context).size.width < 500 ? 14 : 20,
              color: Colors.black45,
            ),
          ),
        ),
        Text(
          Constants.footerText_1,
          style: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.width < 500 ? 14 : 20,
                color: Colors.black45),
          ),
        ),
        const SizedBox(height: 20),
        Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Colors.black45),
      ],
    );
  }
}
