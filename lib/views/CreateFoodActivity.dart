import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateFoodActivity extends StatefulWidget {
  @override
  _CreateFoodActivityState createState() => _CreateFoodActivityState();
}

class _CreateFoodActivityState extends State<CreateFoodActivity> {

  GlobalKey<ScaffoldState>  _globalKey          = GlobalKey<ScaffoldState>();
  File                      _image              = null;
  String                    _imageUrl           = null;

  TextEditingController     _txtName            = TextEditingController();
  TextEditingController     _txtDescription     = TextEditingController();
  TextEditingController     _txtEnable          = TextEditingController();
  TextEditingController     _txtPrice           = TextEditingController();
  TextEditingController     _txtType            = TextEditingController();
  
  Future _getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future _getUriImage(StorageTaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();
    print('Url: ' + url);

    setState(() {
      _imageUrl = url;
    });
  }

  Future saveForm() async {

    if (_image != null) {
      FirebaseStorage storage = FirebaseStorage.instance;
      StorageReference rootFolder = storage.ref();
      StorageReference file = rootFolder.child('food').child('food.jpg');

      StorageUploadTask task = file.putFile(_image);

      task.events.listen((StorageTaskEvent storageEvent) {
        if (storageEvent.type == StorageTaskEventType.progress) {
          _globalKey.currentState.showSnackBar(SnackBar(content: Text('Processando')));
        } else if (storageEvent.type == StorageTaskEventType.success) {
          _globalKey.currentState.showSnackBar(SnackBar(content: Text('Salvo com sucesso')));
        }
      });

      task.onComplete.then((StorageTaskSnapshot snapshot) {
        _getUriImage(snapshot);
      });

    } else {
      _globalKey.currentState.showSnackBar(
          SnackBar(
              content: Text('Nenhuma imagem selecionada!')
          ),
      );
    }

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('Lanches'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save_alt),
              onPressed: saveForm,
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
            Container(
              child: _imageUrl == null ? Text('Nada carregado') : Image.network(_imageUrl),
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
