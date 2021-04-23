import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conexao_01/models/Client.dart';
import 'package:conexao_01/views/Home_List.dart';

class NovoCliente extends StatefulWidget {
    @override _NovoClienteState createState() => _NovoClienteState();
}

class _NovoClienteState extends State<NovoCliente> {
    Firestore firestore = Firestore.instance;
    TextEditingController nameCT = TextEditingController();
    TextEditingController ageCT  = TextEditingController();
    int ageCast = 0;
    String idSave ="";

    create(Client client) async{
        DocumentReference referencia = await firestore
            .collection("clients")
            .add({"name": client.name, "age": client.age,}
        );

        idSave = referencia.documentID;
        setState(() { idSave; });
        print("Register: " + idSave.toString());
    }

    @override void initState() {super.initState();}

    @override Widget build(BuildContext context) {
        return Scaffold(

            appBar: AppBar(
                title: Text("Create"),
                backgroundColor: Colors.blue,
            ),

            body: SingleChildScrollView(child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget> [

                Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0 ),
                    child: TextField(
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: "Name:",),
                        style: TextStyle(fontSize: 20,),
                        onSubmitted: (String getName){print("Entered: " + getName);},
                        controller: nameCT,
                    ),
                ),

                Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0 ),
                    child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: "Age:",),
                        style: TextStyle(fontSize: 20,),
                        onSubmitted: (String getAge){print("Digitado: " + getAge);},
                        controller: ageCT,
                    ),
                ),

                Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10 ),
                    child: Row(children: <Widget> [
                        RaisedButton(
                            onPressed: (){
                                String name   = nameCT.text;
                                ageCast       = int.tryParse(ageCT.text);
                                Client client = Client.Create(name, ageCast);

                                create(client);

                                Navigator.push(context, MaterialPageRoute(builder:
                                    (context) => Home_List())
                                );

                                Timer(Duration(seconds: 2), () => {
                                    setState(() {
                                        print("IdSalvo: " + idSave.toString());
                                    })}
                                );                                                                                                                      //

                            },
                            color: Colors.amber,
                            child: Text("Save"),
                        )

                    ],),
                ),// ...

        ],),),
        );
    }
}
