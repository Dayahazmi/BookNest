import 'package:flutter/material.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          width: 225,
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
                    hintText: null,
                    hintStyle: TextStyle(color: Colors.white, fontSize: 12.0),
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
      ],
    );
  }
}
