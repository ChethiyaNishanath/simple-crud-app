import 'package:flutter/material.dart';
import 'package:coffeeapp/models/brew.dart';
import 'package:provider/provider.dart';

class BrewTile extends StatelessWidget {

  final Brew brew;

  BrewTile({this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[brew.strength],
          ),
          title: Text(brew.name),
          subtitle: Text("Takes ${brew.sugar} sugar(s)."),
        ),
      ),
    );
  }
}


