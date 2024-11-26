import 'package:booknest_fe/screen/homescreen.dart';
import 'package:booknest_fe/widget/searchform.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                const Homescreen(),
            transitionDuration: const Duration(seconds: 0),
            reverseTransitionDuration: const Duration(seconds: 0),
          ),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                const LibraryScreen(),
            transitionDuration: const Duration(seconds: 0),
            reverseTransitionDuration: const Duration(seconds: 0),
          ),
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
                          WidgetStateProperty.all(const Color(0xFF175844))),
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
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                        'Hello, ',
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
              //search form
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SearchForm(),
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
