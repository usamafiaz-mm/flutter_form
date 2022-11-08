import 'dart:io';

import 'package:flutter/material.dart';

class CustomImagePicker extends StatelessWidget {
  CustomImagePicker({Key? key, this.path, required this.onPressed})
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
        InkWell(
          onTap: () {
            onPressed();
          },
          child: Container(
            height: 250,
            width: 250,
            child: path == null
                ? const Placeholder()
                : Image(
                    image: FileImage(
                      File(path!),
                    ),
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
        // ElevatedButton(onPressed: onPressed, child: Text("Pick Image"))
      ],
    );
  }
}
