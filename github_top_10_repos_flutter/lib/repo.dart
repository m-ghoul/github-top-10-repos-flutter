import 'package:flutter/material.dart';

class Repo extends StatelessWidget {
  // Instance variables
  String id;
  String name;
  String stars;

  // Constructor (instance variables must be entered in the exact same order as the constructor)
  Repo(this.id, this.name, this.stars);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      // Card widgets can have elevation to give them a little bit of a shadow
      elevation: 5,
      // We can set many different types of borders for our Card widget
      shape: ContinuousRectangleBorder(
        // We can also define some details related to the border of the card such as the type of border, the color, weight, etc.
        side: BorderSide(
          color: Colors.grey.withOpacity(1),
          width: 1,
        ),
      ),
      // TLRB = Top Left Right Bottom
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
          // You can set the background color of a container along with sizing, padding, etc.
          color: Colors.white,
          width: double.maxFinite,
          height: 100,
          padding: EdgeInsets.all(20),
          // The widget that is displayed within the container
          child: Column(
            children: [
              Text(
                name,
                // In additon to the text that is displayed in Text widgets, we can also define the style of that text
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // The content of text widgets can also include variable values, which can be included as follows
              Text("ID: " + id),
              Text("Stars: " + stars)
            ],
          )),
    ));
  }
}
