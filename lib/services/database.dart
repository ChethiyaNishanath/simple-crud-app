import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeapp/models/brew.dart';
import 'package:coffeeapp/models/user.dart';

class DatabaseService{

  final String uId;

  DatabaseService({this.uId});

  //collection reference
  final CollectionReference brewCollection=Firestore.instance.collection('brews');

  Future updateUserData(String sugar,String name,int strength) async{
    return await brewCollection.document(uId).setData({
      'sugar':sugar,
      'name':name,
      'strength':strength
    });
  }

  //list of brews from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(
          name:doc.data['name'] ?? "",
          strength:doc.data['strength'] ?? 0,
          sugar:doc.data['sugar'] ?? "0");
    }).toList();
  }

  //userData from Snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uId,
      name: snapshot.data['name'],
      strength: snapshot.data['strength'],
      sugars: snapshot.data['sugars']
    );
  }



  //get brew stream when a change happen to a firebase document
  Stream<List<Brew>> get brews {
      return brewCollection.snapshots()
      .map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData{
    return brewCollection.document(uId).snapshots()
        .map(_userDataFromSnapshot);
  }

}