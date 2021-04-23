import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conexao_01/models/Client.dart';
import 'package:conexao_01/views/Home_List.dart';

class Edit_Delete extends StatefulWidget {
    String idCome;
    String nameCome;
    int    ageCome;
    Edit_Delete(this.idCome, this.nameCome, this.ageCome);
    @override _Edit_DeleteState createState() => _Edit_DeleteState();
}

class _Edit_DeleteState extends State<Edit_Delete> {
    TextEditingController nameCT = TextEditingController();
    TextEditingController ageCT  = TextEditingController();
    Firestore firestore = Firestore.instance;

    edit(Client cliente) async{
        firestore.collection("clients")
            .document(cliente.id)
            .setData({"name": cliente.name, "age": cliente.age}
        );
    }

    delete(String id ) async{
        firestore.collection("clients").document(id).delete();
    }

    @override void initState() {super.initState();}

    @override Widget build(BuildContext context) {
        print("Data: ${widget.nameCome} - ${widget.ageCome} ");

        setState(() {
            nameCT.text = widget.nameCome;
            ageCT.text  = widget.ageCome.toString();
        });

        return Scaffold(

            appBar: AppBar(
                title: Text("Edit and Delete"),
                backgroundColor: Colors.green,
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
                        onSubmitted: (String GetText){print("Entered: " + GetText);},
                        controller: nameCT,
                    ),),

                Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0 ),
                    child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: "Age:"),
                        style: TextStyle(fontSize: 20),
                        onSubmitted: (String GetAge){print("Entered: " + GetAge);},
                        controller: ageCT,
                    ),),

                Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0 ),
                    child: Row(children: <Widget> [
                        RaisedButton(
                            onPressed: (){
                                String id   = widget.idCome;
                                String name = nameCT.text;
                                int ageCast = int.tryParse(ageCT.text);
                                Client client = Client.Edit(id, name, ageCast);

                                edit(client);

                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder:
                                    (context) => Home_List())
                                );
                            },
                            color: Colors.amber,
                            child: Text("Edit"),
                        )
                   ],),
               ),

                Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0 ),
                    child: Row(children: <Widget> [
                        RaisedButton(
                          onPressed: (){
                              String id = widget.idCome;

                              delete(id);

                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder:
                                  (context) => Home_List())
                              );
                          },
                          color: Colors.deepOrange,
                          child: Text("Delete"),
                        )
                    ],),
                ),
          ],),),
      );
    }
}
