class Commentsmodel{
  final int postId;
  final int id;
  final String title;
  final String email;
  final String body;


  Commentsmodel({
    required this.postId,
    required this.id,
    required this.title,
    required this.email,
    required this.body,
  });


  factory Commentsmodel.fromJson(Map<String,dynamic>json){

    return Commentsmodel(
        postId: json["postId"],
        id: json["id"],
        title: json["title"],
        email: json["email"],
        body: json["body"]
    );
  }

  Map<String,dynamic> toJson(){
    return{
      "postId":postId,
      "id":id,
      "title":title,
      "email":email,
      "body":body
    };
  }

}