import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:booknest/bookmark/bookmark_page.dart';
import 'package:booknest/constant.dart';
import 'package:booknest/homepage/home_page.dart';
import 'package:booknest/library/library_page.dart';
import 'package:booknest/models/plants.dart';
import 'package:booknest/profile/profile_page.dart';
import 'package:flutter/material.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  List<Plant> favorites = [];
  List<Plant> myCart = [];
  int _bottomNavIndex = 0;

  //list of pages
  List<Widget> page = const [
    HomeScreen(),
    LibraryScreen(),
    BookmarkScreen(),
    ProfileScreen()
  ];

  List<IconData> iconBottom = [
    Icons.home_outlined,
    Icons.library_books_outlined,
    Icons.bookmark_add_outlined,
    Icons.reviews_outlined
  ];

  List<String> titleList = ["Home", "Library", "Bookmark", "Community"];

  void onTap(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 21,
            top: 18,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: SizedBox(
                width: 60,
                height: 60,
                child: Image.asset(
                  'assets/Rectangle 73.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 96,
            top: 18,
            child: Text(
              Constants.greet,
              style: TextStyle(
                  color: Constants.primaryColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Positioned(
              left: 98,
              top: 56,
              child: Text(
                Constants.descriptions,
                style: TextStyle(
                  color: Constants.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              )),
          Positioned(
              left: 300,
              top: 28,
              child: SizedBox(
                width: 42,
                height: 42,
                child: Image.asset('assets/fluent_scan-camera-16-regular.png'),
              )),
          Positioned(
              left: 27,
              top: 95,
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      width: 260,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Constants.seachbarColor,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(
                                child: TextField(
                                    showCursor: false,
                                    //textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      hintText: 'Search Book',
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.normal),
                                      focusedBorder: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 10.0),
                                    ))),
                            Icon(
                              Icons.search,
                              color: Colors.black54.withOpacity(.6),
                            )
                          ]),
                    )
                  ],
                ),
              )),
          Positioned(
              left: 30,
              top: 170,
              child: SizedBox(
                width: 191,
                height: 48,
                child: Text(
                  'Reading Tracker',
                  style: TextStyle(
                      color: Constants.secondaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              )),
          Positioned(
            left: 25,
            top: 210,
            child: Container(
              width: 300,
              height: 178,
              decoration: BoxDecoration(
                color: const Color(0xFFF9f0DE),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  // Positioned widget for "Readings Goals" and Image
                  Positioned(
                    left: 10, // Adjust the left position as needed
                    top: 15, // Adjust the top position as needed
                    child: Row(
                      children: [
                        Text(
                          'Readings Goals',
                          style: TextStyle(
                            color: Constants.secondaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                            width:
                                110), // Adds space between the text and the image
                        Image.asset(
                          'assets/arcticons_letter-lowercase-circle-i.png',
                          width: 24, // Adjust the width and height as needed
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                  // Positioned widget for the second text
                  Positioned(
                    left: 10, // Adjust the left position as needed
                    top:
                        50, // Adjust the top position as needed, which is below the "Readings Goals" row
                    child: Text(
                      "You've reading 3 out of 7 days this week",
                      style: TextStyle(
                        color: Constants.secondaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 90,
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Centers the row content
                      children: List.generate(7, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4.0), // Adds spacing between images
                          child: Image.asset(
                            'assets/Frame 65.png', // Replace with your image path
                            width: 30, // Adjust the width and height as needed
                            height: 61,
                          ),
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
          splashColor: Colors.greenAccent,
          activeColor: Constants.primaryColor,
          inactiveColor: Colors.grey,
          icons: iconBottom,
          iconSize: 28,
          gapLocation: GapLocation.none,
          notchSmoothness: NotchSmoothness.defaultEdge,
          activeIndex: _bottomNavIndex,
          onTap: (index) {
            setState(() {
              _bottomNavIndex = index;
              final List<Plant> favoritePlants = Plant.getFavoritedPlants();
              final List<Plant> addedToCartPlants = Plant.addedToCartPlants();

              favorites = favoritePlants;
              myCart = addedToCartPlants.toSet().toList();
            });
          }),
    );
  }
}
