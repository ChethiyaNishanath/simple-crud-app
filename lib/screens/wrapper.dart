import 'package:flutter/material.dart';
import 'package:coffeeapp/screens/authenticate/authenticate.dart';
import 'package:coffeeapp/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:coffeeapp/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // 8 user data from provider
    final user=Provider.of<User>(context);

    //return home either authenticate
    return (user==null)?Authenticate():Home();
  }
}
