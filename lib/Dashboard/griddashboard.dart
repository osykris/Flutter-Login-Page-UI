import 'package:day12_login/Calculation/calculate.dart';
import 'package:day12_login/Money/pages/home.dart';
import 'package:day12_login/PrayTime/praytime_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var color = 0xff453658;
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Berisi fitur fitur (dengan card yang nanti jika diklik akan menuju ke halaman selanjutnya)
          Expanded(
            child: GridView.count(
              childAspectRatio: 1.0,
              padding: EdgeInsets.only(left: 16, right: 16),
              crossAxisCount: 2,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              children: <Widget>[
                GestureDetector(
                  onTap: () { Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Money()),
                    );},
                  child: Card(
                    color: Color(color),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: 50,
                            child: Image.asset('assets/shopping.png'),
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          "My Money",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "See the money coming in",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.white38,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CalculateTransaction()),
                    );
                  },
                  child: Card(
                    color: Color(color),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: 50,
                            child: Image.asset('assets/information.png'),
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          "Calculation",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Count Transactions",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.white38,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrayTimeScreen()),
                    );},
                  child: Card(
                    color: Color(color),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: 50,
                            child: Image.asset('assets/calendar.png'),
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          "Prayer Times",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Subuh until Isha'",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.white38,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Card(
                    color: Color(color),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: 50,
                            child: Image.asset('assets/todo.png'),
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          "To Do",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Homework, Note",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.white38,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600)),
                        ),
                         SizedBox(
                          height: 14,
                        ),
                      ],
                    ),
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
