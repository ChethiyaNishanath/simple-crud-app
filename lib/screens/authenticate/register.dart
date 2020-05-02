import 'package:flutter/material.dart';
import 'package:coffeeapp/services/auth.dart';
import 'package:coffeeapp/shared/constants.dart';
import 'package:coffeeapp/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth=AuthService();

  //Authentication before sign in with email
  //unique key for identify a form
  final _formKey=GlobalKey<FormState>();

  //loading spinner trigger
  bool isLoading=false;

  //text field state
  String email="";
  String pass="";

  String error="";

  @override
  Widget build(BuildContext context) {
    return (isLoading)?Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text("Sign Up"),
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
                "Sign In",
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
                  "Register",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onPressed: ()async{
                  if(_formKey.currentState.validate()) {
                    setState(() {
                      isLoading=true;
                    });
                    dynamic result=await
                    _auth.registerWithEmailAndPass(email,pass);
                    if(result==null){
                      setState(() {
                        isLoading=false;
                        error="Supply a valid email";
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
      ),
    );
  }
}
