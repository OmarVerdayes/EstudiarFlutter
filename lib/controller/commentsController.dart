import 'dart:convert';
import "package:http/http.dart" as http;

const baseURL="https://jsonplaceholder.typicode.com/comments";

class Commentscontroller{




  Future<dynamic> save(int postId,int id,String name,String email,String body)async{
     var data=json.encode(
         {
           "postId":postId,
           "id":id,
           "name":name,
           "email":email,
           "body":body
         }
     );

    try{
      var response = await http.post(
          Uri.parse(baseURL),
          body:data,
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }
      );
      var bodyR= jsonDecode(response.body);

      print(bodyR);
      return bodyR;

    }catch(e){
      print(e);
      rethrow;
    }

  }

  Future<dynamic> update(int postId,int id,String name,String email,String body)async{
    var data=json.encode(
        {
          "postId":postId,
          "id":id,
          "name":name,
          "email":email,
          "body":body
        }
    );
    try{
      var response = await http.put(
          Uri.parse("${baseURL}/${id}"),
          body:data,
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }
      );
      var bodyR= jsonDecode(response.body);
      print(bodyR);
      return bodyR;
    }catch(e){
      print(e);
      rethrow;
    }

  }

  Future<void> delete(int id)async{

    try{
      var response= await http.delete(
          Uri.parse("${baseURL}/${id}"),
      );

      print("Eliminado: ${jsonDecode(response.body)}");
    }catch(e){
      print(e);
      rethrow;
    }

  }

}