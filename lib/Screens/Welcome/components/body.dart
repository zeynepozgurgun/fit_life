import "package:flutter/material.dart";

class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size; //This size provide us total height and width of ou screen
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
          child:Image.asset(
          "assets/images/image-1.jpeg",
          width: size.width*0.3,
          ),
          ),
          Positioned(child: Image.asset("assets/images/image-1.jpeg"))
          ]),
    );
  }
}