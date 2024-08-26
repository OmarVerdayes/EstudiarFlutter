import 'dart:convert';
import 'dart:math';

import 'package:estudiar_extra/controller/commentsController.dart';
import 'package:estudiar_extra/model/commentsModel.dart';
import 'package:estudiar_extra/views/AddComment.dart';
import 'UpddateComment.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Listcomments extends StatefulWidget {
  const Listcomments({super.key});

  @override
  State<Listcomments> createState() => _ListcommentsState();
}

Commentscontroller controller=Commentscontroller();

class _ListcommentsState extends State<Listcomments> {

  Future<List<dynamic>> getData()async{
    final resposne=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/comments"));
    if(resposne.statusCode==200){
      print(json.decode(resposne.body));

      return json.decode(resposne.body);
    }else{
      throw Exception("Error al consultar");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Lista de comentarios"),
        actions: [
          ElevatedButton(
              onPressed: () =>{
              Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext comntext)=>
              Addcomment())
              )
          },
              child: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: getData(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return Center(child: Text("Error: ${snapshot.error}"),);
          }
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }
          return Center(child: ItemList(
                list: snapshot.data!,
                onUpdate: ()=> setState(() {}),
              )
            ,);
      }
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List<dynamic>list;
  final VoidCallback  onUpdate;

  const ItemList({
    required this.list,
    required this.onUpdate
});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context,i){
        return Column(
          children: [
            Container(
              child: Container(
                width: double.infinity,
                child: Card(
                  color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Email: ${list[i]['email']?? 'N/A'}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Nombre: ${list[i]['name']?? 'N/A'}",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Cuerpo: ${list[i]['body']?? 'N/A'}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(10.0),
                                child:ElevatedButton(
                                  child: Text(
                                    "Actualizar",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                                  onPressed: ()  {
                                   Navigator.of(context).push(
                                        MaterialPageRoute(builder: (BuildContext comntext)=>
                                            Upddatecomment(
                                              list: list,
                                              index: i,
                                            ))
                                    );
                                  },
                                ),
                            ),

                            Padding(padding: const EdgeInsets.all(10.0),
                                child:ElevatedButton(
                                  child: Text(
                                    "Eliminar",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                  onPressed: () async=> await controller.delete(list[i]['id']),
                                ),
                            )
                          ],
                        )

                      ),
                    ],
                  ),
                ),
              )
            )
          ],
        );
      },
    );
  }
}


