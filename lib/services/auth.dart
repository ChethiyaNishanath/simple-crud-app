import 'package:firebase_auth/firebase_auth.dart';
import 'package:coffeeapp/models/user.dart';
import 'package:coffeeapp/services/database.dart';

class AuthService{

  // 1 instance of firebase authentication
  final FirebaseAuth _auth=FirebaseAuth.instance;

  // 6 create user object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user){
    return user!=null?new User(uId: user.uid):null;
  }

  // 7 auth change user
  Stream<User> get user{
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user)=>_userFromFirebaseUser(user));
          .map(_userFromFirebaseUser);
  }

  // 2 sign in anonymously
  Future signInAnon() async{
    try{
      AuthResult result=await _auth.signInAnonymously();
      FirebaseUser user=result.user;

      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign in with email
  Future signInWithEmailAndPass(String email,String pass) async {
    try{
      AuthResult result=await _auth
          .signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user=result.user;

      //create a new document for the user with the uid provided by firebase
      await DatabaseService(uId: user.uid).updateUserData("0","New Member", 100);

      return _userFromFirebaseUser(user);

    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email
  Future registerWithEmailAndPass(String email,String pass) async{
    try{
      AuthResult result=await _auth
          .createUserWithEmailAndPassword(email: email, password: pass);

      FirebaseUser user=result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOutAnon() async{
      try {
        return await _auth.signOut();
      }
      catch(e){
        print((e.toString()));
        return null;
      }
    }
}