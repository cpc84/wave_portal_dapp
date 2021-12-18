import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wave_portal_dapp/models/wave.dart';

import '../constants.dart';

class Messages extends StatelessWidget {
  final List<Wave> waves;
  const Messages({Key? key, required this.waves}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: waves.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${Constants.messageText_1} ${waves[index].address}',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width < 500
                                        ? 14
                                        : 20)),
                      ),
                      Text(
                        '${Constants.messageText_2} ${waves[index].message}',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width < 500
                                        ? 14
                                        : 20)),
                      ),
                      Text(
                        '${Constants.messageText_3} ${DateFormat('yyyy-MM-dd - kk:mm').format(DateTime.fromMillisecondsSinceEpoch(int.parse(waves[index].timeStamp) * 1000))}',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width < 500
                                        ? 14
                                        : 20)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ]);
          },
        ),
      ),
    );
  }
}
