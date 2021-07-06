import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class Api extends StatefulWidget {

  @override
  _ApiState createState() => _ApiState();
}

class _ApiState extends State<Api> {
  getUser() async{
    var users = [];
    var response = await http.get(Uri.https('jsonplaceholder.typicode.com','users'));
    var jsonData = jsonDecode(response.body);

    for(var i in jsonData){
      UserModel user = UserModel(i['name'],i['username'],i['email'],i['company']['catchPhrase'],i['address']['city']);
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getUser(),
        builder: (context,AsyncSnapshot snapshot){
          if(snapshot.data == null){
            return Container(child: Text("Nothing in Api"),);
          }
          else return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context,i){
              return ListTile(
                title: Text(snapshot.data[i].name),
                subtitle: Text(snapshot.data[i].company),
                trailing: Text(snapshot.data[i].address),
                );
          },);
        },
      )
    );
  }
}

class UserModel{
  var name;
  var userName;
  var email;
  var company;
  var address;

  UserModel(this.name, this.userName, this.email, this.company, this.address);
}