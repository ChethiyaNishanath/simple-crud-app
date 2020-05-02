import 'package:flutter/material.dart';
import 'package:coffeeapp/models/brew.dart';
import 'package:coffeeapp/screens/home/brew_list.dart';
import 'package:coffeeapp/screens/home/settings_form.dart';
import 'package:coffeeapp/services/auth.dart';
import 'package:coffeeapp/services/database.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget {

  final AuthService _auth=AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingPanel(){
      showModalBottomSheet(
          context: context,
          builder: (context){
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("MY App"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                icon: Icon(
                    Icons.person,
                    color: Colors.white,
                ),
                label: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                ),
                onPressed: ()async {
                  await _auth.signOutAnon();
                },
            ),
            FlatButton.icon(
                onPressed: ()=>_showSettingPanel(),
                icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                ),
                label: Text(
                    "Settings",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Container(
            child: BrewList(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/coffee.jpg"),
              fit: BoxFit.cover,
            )
          ),
        ),
      ),
    );
  }
}
