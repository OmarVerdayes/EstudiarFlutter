import 'package:estudiar_extra/controller/commentsController.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class Upddatecomment extends StatefulWidget {
  final List list;
  final int index;

  const Upddatecomment({required this.list,required this.index});

  @override
  State<Upddatecomment> createState() => _UpddatecommentState();
}

class _UpddatecommentState extends State<Upddatecomment> {
  late TextEditingController postIdC;
  late TextEditingController idC;
  late TextEditingController nameC;
  late TextEditingController emailC;
  late TextEditingController bodyC;


  @override
  void initState() {
    super.initState();
    postIdC= TextEditingController(text: widget.list[widget.index]["postId"].toString());
    idC= TextEditingController(text: widget.list[widget.index]["id"].toString());
    nameC= TextEditingController(text: widget.list[widget.index]["name"].toString());
    emailC= TextEditingController(text: widget.list[widget.index]["email"].toString());
    bodyC= TextEditingController(text: widget.list[widget.index]["body"].toString());
  }

  Commentscontroller controller=Commentscontroller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar comentario"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
            children: [
              _buildTextField(postIdC,"postId","Ingrese el id del post"),
              const SizedBox(height: 16,),
              _buildTextField(idC,"idC","Ingrese el id del comentario"),
              const SizedBox(height: 16,),
              _buildTextField(nameC,"name","Ingrese su nombre"),
              const SizedBox(height: 16,),
              _buildTextField(emailC,"email","Ingrese su email"),
              const SizedBox(height: 16,),
              _buildTextField(bodyC,"body","Ingrese su comentario"),
              const SizedBox(height: 16,),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: ()async{
                      try{
                        var response= await controller.update(
                          int.parse(postIdC.text.trim()),
                          int.parse(idC.text.trim()),
                          nameC.text.trim(),
                          emailC.text.trim(),
                          bodyC.text.trim(),
                        );
                      }catch(e){
                        print("Error: ${e}");
                      }
                      Navigator.pop(context,true);
                    },
                    child:  Text(
                      "Agregar",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  ),
                  ElevatedButton(
                    onPressed: () =>{
                      Navigator.pop(context,true)
                    },
                    child:  Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  )

                ],
              ),

            ]
        ),
      ),
    );
  }


  Widget _buildTextField(TextEditingController controller, String label, String hint) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo es obligatorio';
          }
          return null;
        },
      ),
    );
  }


  Widget _buildNumberField(TextEditingController controller, String label, String hint) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo es obligatorio';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildEmailField(TextEditingController controller, String label, String hint) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo es obligatorio';
          }
          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
          if (!emailRegex.hasMatch(value)) {
            return 'Ingrese un correo electrónico válido';
          }
          return null;
        },
      ),
    );
  }

}
