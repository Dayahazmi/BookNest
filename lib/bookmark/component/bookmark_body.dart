import 'package:flutter/material.dart';

class BookmarkBody extends StatefulWidget {
  const BookmarkBody({super.key});

  @override
  State<BookmarkBody> createState() => _BookmarkBodyState();
}

class _BookmarkBodyState extends State<BookmarkBody> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Bookmark'),
      ),
    );
  }
}
