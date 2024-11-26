import 'package:booknest_fe/widget/appbar.dart';
import 'package:booknest_fe/widget/dropdown.dart';
import 'package:booknest_fe/widget/searchform.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
                child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [SearchForm(), SizedBox(width: 15), MyDropDown()],
                  ),
                )
              ],
            )),
          ),
        ));
  }
}
