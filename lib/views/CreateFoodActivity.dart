import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateFoodActivity extends StatefulWidget {
  @override
  _CreateFoodActivityState createState() => _CreateFoodActivityState();
}

class _CreateFoodActivityState extends State<CreateFoodActivity> {
  
  File _image;
  TextEditingController _txtName            = TextEditingController();
  TextEditingController _txtDescription     = TextEditingController();
  TextEditingController _txtEnable          = TextEditingController();
  TextEditingController _txtPrice           = TextEditingController();
  TextEditingController _txtType            = TextEditingController();
  
  Future _getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lanches'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save_alt),
              onPressed: (){},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            input('Nome', _txtName),
            input('Descrição', _txtDescription),
            input('ativo', _txtEnable),
            input('price', _txtPrice),
            OutlineButton(
              onPressed: _getImage,
              child: Text('Carregar imagem'),
              color: Colors.red,
            ),
            SizedBox(height: 20,),
            Container(
              child: _image == null ? Text('Nada selecionado') : Image.file(_image),
            ),
          ],
        ),
      )
    );
  }

  Widget input(hint, controller) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
        child: TextFormField(
          cursorColor: Colors.red,
          keyboardType: TextInputType.text,
          autocorrect: true,
          controller: controller,
          style: TextStyle(
              color: Colors.black,
              decorationColor: Colors.red,
              fontSize: 17
          ),
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                  color: Colors.grey
              ),
              border: OutlineInputBorder()
          ),
        )
    );
  }
}
