import 'package:flutter/material.dart';

final TextInputDecoration=InputDecoration(
    fillColor:Colors.brown[100],
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)) ,
      borderSide: BorderSide(
        color: Colors.brown,
        width: 2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.pinkAccent,
          width: 2,
        )
    )
);