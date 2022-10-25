import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';

class CustomPicker extends StatelessWidget {
  CustomPicker({Key? key, this.path, required this.onPressed})
      : super(key: key);
  String? path;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (path == null)
          const Text(
            "*Select your own Image",
            style: TextStyle(color: Colors.red),
          ),
        Container(
          height: 250,
          width: 250,
          child: path == null
              ? Image.network(
                  "https://loremflickr.com/640/360",
                  fit: BoxFit.cover,
                )
              : Image.file(
                  File(path!),
                  fit: BoxFit.cover,
                ),
        ),
        ElevatedButton(onPressed: onPressed, child: Text("Pick Image"))
      ],
    );
  }
}
