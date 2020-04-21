import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class CreateFoodActivity extends StatefulWidget {
  @override
  _CreateFoodActivityState createState() => _CreateFoodActivityState();
}

class _CreateFoodActivityState extends State<CreateFoodActivity> {

  File                      _image;
  String                    _imageUrl;
  GlobalKey<ScaffoldState>  _globalKey          = GlobalKey<ScaffoldState>();

  TextEditingController     _txtName            = TextEditingController();
  TextEditingController     _txtDescription     = TextEditingController();
  TextEditingController     _txtEnable          = TextEditingController();
  TextEditingController     _txtPrice           = TextEditingController();
  TextEditingController     _txtType            = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('Lanches'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save_alt),
              onPressed: confirmForm,
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

  /// Métodos para gerência de regras de negócio
  Future<String> saveData(String nameID) async {
    if (_image != null) {
      FirebaseStorage storage = FirebaseStorage.instance;
      StorageReference rootFolder = storage.ref();
      StorageReference file = rootFolder.child(nameID + '.jpg');

      StorageUploadTask task = file.putFile(_image);

      task.events.listen((StorageTaskEvent storageEvent) {
        if (storageEvent.type == StorageTaskEventType.progress) {
          print('Processando');
        } else if (storageEvent.type == StorageTaskEventType.success) {
          print('Salvo com sucesso');
        }
      });

      task.onComplete.then((StorageTaskSnapshot snapshot) {
        _getUriImage(snapshot).then((response) {
          saveFirebaseData(nameID, response);
        });
      });
    }

    showMessage('Nenhuma imagem selecionada!');
    return '';
  }

  Future saveFirebaseData(String id, String url) {
    Firestore.instance.collection('products').document(id).setData({
      'name': _txtName.text,
      'description': _txtDescription.text,
      'enable': '0',
      'price': _txtPrice.text,
      'type': 'food',
      'image': url
    });
    showMessage('Dados salvos com sucesso');
  }

  Future confirmForm() async {
    String message;
    bool valid = true;

    if (_txtName.text.isEmpty || _txtDescription.text.isEmpty || _txtPrice.text.isEmpty) {
      message = 'preencha todos os campos antes de salvar';
      valid = false;
    }

    if (valid) {
      String id = _txtName.text + DateTime.now().millisecondsSinceEpoch.toString();
      await saveData(id);
    } else {
      showMessage(message);
    }
  }

  Future _getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future<String> _getUriImage(StorageTaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();
    setState(() {
      _imageUrl = url;
    });
    return url;
  }

  /// Widgets auxiliares
  /// Widget que não participa da regra de negócio
  Widget input(hint, controller) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
        child: TextFormField(
          cursorColor: Colors.red,
          keyboardType: TextInputType.text,
          autocorrect: true,
          controller: controller,
          style: TextStyle(
              color: Colors.white,
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

  /// Funcionalidades auxiliares
  /// Sem interferência nas regras ded negócio da aplicação
  void showMessage(String message) {
    _globalKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
            message,
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.red[900],
        action: SnackBarAction(
            label: 'Certo!',
            textColor: Colors.white,
            onPressed: (){}
        ),
      ),
    );
  }
}
