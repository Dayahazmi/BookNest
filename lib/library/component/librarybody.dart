import 'package:flutter/material.dart';

class LibraryScreenBody extends StatefulWidget {
  const LibraryScreenBody({super.key});

  @override
  State<LibraryScreenBody> createState() => _LibraryScreenBodyState();
}

class _LibraryScreenBodyState extends State<LibraryScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            left: 21,
            //top: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 60,
                height: 60,
                child: Image.asset('assets/Rectangle 73.png'),
              ),
            ))
      ],
    ));
  }
}
