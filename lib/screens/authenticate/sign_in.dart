import 'dart:math';

import 'package:flutter/material.dart';
import 'package:coffeeapp/screens/authenticate/register.dart';
import 'package:coffeeapp/services/auth.dart';
import 'package:coffeeapp/shared/constants.dart';
import 'package:coffeeapp/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}



class _SignInState extends State<SignIn> {

  //3 instance of auth for auth in anonymously
  final AuthService _auth=AuthService();

  //Authentication before sign in with email
  //unique key for identify a form
  final _formKey=GlobalKey<FormState>();

  // loading spinner trigger
  bool loading=false;

  //text field state
  String email="";
  String pass="";
  String error="";

  @override
  Widget build(BuildContext context) {
    //show loading or the scaffold
    return (loading)?Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text("SignIn"),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: (){
                widget.toggleView();
              },
              icon: Icon(
                  Icons.person,
                  color: Colors.white,
              ),
              label: Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white
                  ),
              )
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/coffee.jpg'),
              fit: BoxFit.cover
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              TextFormField(
                decoration: TextInputDecoration.copyWith(hintText: "Email"),
                validator: (val)=>val.isEmpty?"Enter Email":null,
                onChanged: (val){
                  setState(() {
                    email=val;
                  });
                },

              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: TextInputDecoration.copyWith(hintText: "Password"),
                validator: (val)=>val.length<6?"Enter Password with 6+ chars":null,
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    pass=val;
                  });
                },


              ),
              SizedBox(height: 20,),
              RaisedButton(
                color: Colors.redAccent,
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                onPressed: ()async{

                  if(_formKey.currentState.validate()) {
                    setState(() {
                      loading=true;
                    });
                    dynamic result=await
                    _auth.signInWithEmailAndPass(email, pass);
                    if(result==null){
                      setState(() {
                        error="Couldn't Sign in.";
                        loading=false;
                      });
                    }
                  }else{
                    print("Validation Failed");
                  }
                },
              ),
              SizedBox(height: 12,),
              Text(
                error,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 14
                ),
              ),
            ],
          ),
        ),
//        child: RaisedButton(
//          child: Text("SignIn Anon"),
//          onPressed: () async{
//            //4 try to get in anonymously
//            dynamic result=await _auth.signInAnon();
//            if(result==null)
//              print("Error Sign in");
//            else {
//              print("Signed In");
//              print(result.uId);
//            }
//          },
//        ),
      ),
    );
  }
}
