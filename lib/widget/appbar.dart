import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double heightFactor; // Percentage of screen height to use for AppBar

  const MyAppBar(
      {super.key, this.heightFactor = 0.15}); // Default: 15% of screen height

  @override
  Widget build(BuildContext context) {
    // Calculate height based on screen size
    final double appBarHeight =
        MediaQuery.of(context).size.height * heightFactor;

    return Container(
      height: appBarHeight,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150'), // Replace with your image
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize:
                    MainAxisSize.min, // To minimize vertical space usage
                children: const [
                  Text(
                    'Hello Jun',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'What do you like to read today?',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.camera_alt_outlined,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      70); // Placeholder height; actual height comes from `MediaQuery`.
}
