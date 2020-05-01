import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoCards extends StatelessWidget {
  InfoCards({@required this.title, @required this.data, @required this.textSize, this.cardColor});
  final formatter = new NumberFormat("#,###");
  final int data;
  final String title;
  final double textSize;
  final Color cardColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: cardColor,
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
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: textSize,
                  ),
                ),
                Text(
                  formatter.format(data),
                  style: TextStyle(
                    fontSize: textSize,
                    color: Colors.white,
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
