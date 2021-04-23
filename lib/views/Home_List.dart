import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conexao_01/models/Client.dart';
import 'package:conexao_01/views/NewClient.dart';
import 'package:conexao_01/views/Edit_Delete.dart';

class Home_List extends StatefulWidget {
    @override _Home_ListState createState() => _Home_ListState();
}

class _Home_ListState extends State<Home_List> {
    Firestore firestore = Firestore.instance;
    Client client;
    List<Client> Client_List = [];
    String msg = "Updating ...";

    Future<List<Client>> findAll() async{
        QuerySnapshot querySnapshot = await firestore
            .collection("clients")
            .getDocuments();

        for(DocumentSnapshot item in querySnapshot.documents){
            var register = item.data;
            print("Register: " + register["name"] + "-" + register["age"].toString());
        }

        for(DocumentSnapshot item in querySnapshot.documents){
            var register = item.data;
            String name  = register["name"];
            int    age   = register["age"];

            client = Client.Create(name, age);
            Client_List.add(client);
        }

        setState(() {Client_List;});
        return Client_List;
    }

    Future<List<Client>> findAllRealTime() async{
        firestore.collection("clients").snapshots().listen((findData) {
            for(DocumentSnapshot item in findData.documents) {
                var register = item.data;
                String id    = item.documentID;
                String name  = register["name"];
                int age      = register["age"];

                client = Client.Edit(id, name, age);
                Client_List.add(client);
            }
        });

        setState(() {Client_List;});
        return Client_List;
    }

    @override void initState() {
        super.initState();
        if(Client_List == null || Client_List.length < 1){
            findAllRealTime();
        }

        Timer(Duration(seconds: 3), () => {
            setState(() {
                Client_List.clear();
                msg = "";
                findAllRealTime();
            })
        });
    }

    @override Widget build(BuildContext context) {
        return Scaffold(

            appBar: AppBar(
                title: Text("List of Clients"),
                backgroundColor: Colors.blue,
            ),

            body: Column(children: <Widget> [

                Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 0, 0 ),
                    child: Row(children: <Widget> [
                        RaisedButton(
                            onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder:
                                    (context) => NovoCliente()
                                ));
                            },
                            color: Colors.amber,
                            child: Text("Create"),
                        )
                    ],),
                ),

                Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Text(
                        msg,
                        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
                    ),
                ),

                Expanded(child: ListView.builder(
                    itemCount: Client_List.length,
                    itemBuilder: (context, index){
                        final item = Client_List[index];

                        return Card(child: ListTile(
                            title: Text(item.name),
                            subtitle: Text("${item.name}"" - ${item.age}"),
                            onTap: (){
                                print(item.id);
                                Navigator.push(context, MaterialPageRoute(builder:
                                    (context) =>
                                        Edit_Delete(item.id, item.name, item.age)
                                ));
                            },
                        ));}
                ))
            ],),
        );
    }  //Método Context
}  //Classe State