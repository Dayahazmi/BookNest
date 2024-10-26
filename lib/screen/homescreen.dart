import 'dart:convert';

import 'package:booknest_fe/screen/libraryscren.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:dropdown_button2/dropdown_button2.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedIndex = 0;
  int bookCount = 0;
  String nameUser = '';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to the corresponding page
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RootScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LibraryScreen()),
        );
        break;
      case 2:
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const SchoolPage()),
        // );
        break;
    }
  }

  Future<void> fetchBook() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) return;

    try {
      final response = await http.post(
          Uri.parse("http://192.168.1.111:3000/book/BookCount"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final int count = data['count'] ?? 0;

        setState(() {
          bookCount = count;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred: $e');
      }
    }
  }

  Future<void> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (kDebugMode) {
      print({'token:', token});
    }

    if (token == null || token.isEmpty) {
      if (kDebugMode) {
        print('Didn\'t receive any token');
      }
      return; // Return early if token is null
    }

    try {
      final response = await http.post(
          Uri.parse("http://192.168.1.111:3000/profile/getProfile"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });

      if (kDebugMode) {
        print('response.body : ${response.body}');
      }

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Access the nested 'profile' and 'name' fields
        final profile = data['profile'];
        final String? name = profile?['name']; // Ensure 'profile' is not null

        if (name != null) {
          setState(() {
            nameUser = name; // Set the user's name from the profile
          });
        } else {
          if (kDebugMode) {
            print('Name is null in the profile');
          }
        }
      } else {
        if (kDebugMode) {
          print('Failed to load profile. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred: $e');
      }
    }
  }

  Dialog _captureDetailBook(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
          height: 350,
          padding: const EdgeInsets.all(16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/Vector.png', scale: 2.5),
                const SizedBox(height: 20),
                Text('Scan your book cover to',
                    style: GoogleFonts.mulish(
                        fontSize: 17, fontWeight: FontWeight.w400)),
                const SizedBox(height: 15),
                Text(
                  'start adding it in your Library',
                  style: GoogleFonts.mulish(
                      fontSize: 17, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF175844))),
                  onPressed: () {},
                  child: Text('Scan Cover',
                      style: GoogleFonts.mulish(
                          fontSize: 17, color: Colors.white)),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Skip for now',
                    style: GoogleFonts.mulish(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ])),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchBook();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25, left: 20),
                    child: SizedBox(
                      height: 48,
                      width: 48,
                      child: Image.asset('assets/Rectangle 73.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, $nameUser',
                        style: GoogleFonts.mulish(
                            fontSize: 17.0,
                            color: const Color(0xFF0A2C22),
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'What do you like to read?',
                        style: GoogleFonts.mulish(
                          fontSize: 14.0,
                          color: const Color(0xFF0A2C22),
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25, left: 40),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return _captureDetailBook(context);
                          },
                        );
                      },
                      child: SizedBox(
                        height: 48,
                        width: 48,
                        child: Image.asset(
                            'assets/fluent_scan-camera-16-regular.png'),
                      ),
                    ),
                  ),
                )
              ]),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    width: 250,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color(0xFF7A7A7A),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                              child: TextField(
                            showCursor: false,
                            decoration: InputDecoration(
                              hintText: 'Search Book',
                              hintStyle: TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            textAlign: TextAlign.left,
                            textAlignVertical: TextAlignVertical.center,
                          )),
                          Icon(
                            Icons.search,
                            color: Colors.black54.withOpacity(.6),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 80,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('All')],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text('Reading Tracker',
                        style: GoogleFonts.mulish(
                            fontWeight: FontWeight.bold, fontSize: 20.0)),
                  )),
              const SizedBox(
                height: 10,
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 325,
                      height: 150,
                      decoration: BoxDecoration(
                          color: const Color(0xFFFFF9E6),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Color(0xFFD9D9D9),
                                spreadRadius: 2.5,
                                blurRadius: 3,
                                offset: Offset(0, 3))
                          ]),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 20),
                                  child: Text(
                                    'Reading Goals',
                                    style: GoogleFonts.mulish(
                                        color: const Color(0xFF177B4D),
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, right: 20),
                                    child: Icon(Icons.info_outline_rounded),
                                  ),
                                ),
                              ]),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                'You\'ve reading 3 out of 7 books this week\nKeep it up!',
                                style: GoogleFonts.mulish(
                                    fontSize: 13.5,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                  7,
                                  (index) => Image.asset(
                                        'assets/Frame 70.png',
                                      )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 140,
                          height: 150,
                          decoration: BoxDecoration(
                              color: const Color(0xFFC0D2AD),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0xFFD9D9D9),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(0, 3))
                              ]),
                          child: Column(
                            children: [
                              //reading hours
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, left: 70),
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Image.asset(
                                          'assets/mingcute_time-duration-line.png'),
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '21',
                                    style: GoogleFonts.mulish(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Reading hours\nthis month',
                                    style: GoogleFonts.mulish(
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      //jumlah buku
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          width: 140,
                          height: 150,
                          decoration: BoxDecoration(
                              color: const Color(0xFF43182F),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0xFFD9D9D9),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(0, 3))
                              ]),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, left: 70),
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Image.asset('assets/ph_book.png'),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '$bookCount',
                                    style: GoogleFonts.mulish(
                                      fontSize: 28.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Total book this month',
                                    style: GoogleFonts.mulish(
                                      fontSize: 17.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                  //genre
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 140,
                          height: 150,
                          decoration: BoxDecoration(
                              color: const Color(0xFF9AE6B4),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0xFFD9D9D9),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(0, 3))
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, left: 70),
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Image.asset(
                                          'assets/material-symbols-light_explore-outline.png'),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '3',
                                      style: GoogleFonts.mulish(
                                        fontSize: 28.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Current Genre',
                                      style: GoogleFonts.mulish(
                                        fontSize: 17.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      //progress
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          width: 140,
                          height: 150,
                          decoration: BoxDecoration(
                              color: const Color(0xFFD69E2E),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0xFFD9D9D9),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(0, 3))
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Image.asset(
                                        'assets/ic_baseline-auto-graph.png'),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '70%',
                                      style: GoogleFonts.mulish(
                                        fontSize: 28.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Paperback Book\nBy Format',
                                      style: GoogleFonts.mulish(
                                        fontSize: 13.5,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.library_books,
              ),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bookmark,
              ),
              label: 'Bookmark',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Community',
            )
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF0A2C22),
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ));
  }
}
