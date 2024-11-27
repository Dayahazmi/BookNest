import 'package:flutter/material.dart';

class MyDropDown extends StatefulWidget {
  const MyDropDown({super.key});

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

const List<String> list = <String>['All', 'Romance', 'Horror', 'Thriller'];

class _MyDropDownState extends State<MyDropDown> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down,
          size: 20), // Icon size can be adjusted
      iconSize: 20, // Remove the default padding between icon and text
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      selectedItemBuilder: (BuildContext context) {
        return list.map((String value) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          );
        }).toList();
      },

      isDense: true,
    );
  }
}
