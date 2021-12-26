

import 'package:flutter/material.dart';

class AvatarPreview extends StatelessWidget {
  final String avatar;
  const AvatarPreview({Key? key, required this.avatar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(tag: "avatar_preview", child: Material(
      color: Colors.black,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: GestureDetector(
            onTap: ()=> Navigator.of(context).pop(),
            child: Icon(Icons.arrow_back, color:  Theme.of(context).colorScheme.secondary,),
          ),
        ),
        body: Center(
          child: InteractiveViewer(
            panEnabled: false,
            boundaryMargin: const EdgeInsets.all(100),
            minScale: 0.5,
            maxScale: 2,
            scaleEnabled: true,
            child: Image.network(
              avatar,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ),);
  }
}
