import 'package:flutter/material.dart';

class InfoCards extends StatelessWidget {
  InfoCards({@required this.title, @required this.data});

  final int data;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(7),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(1, 1),
                  spreadRadius: 1,
                  blurRadius: 1,
                )
              ],
            ),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 30,

                  ),
                ),
                Text(
                  data.toString(),
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
