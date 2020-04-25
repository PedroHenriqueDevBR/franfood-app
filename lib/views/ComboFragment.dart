import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:franfood/views/ShowFoodActivity.dart';

class ComboFragment extends StatefulWidget {
  @override
  _ComboFragmentState createState() => _ComboFragmentState();
}

class _ComboFragmentState extends State<ComboFragment> {
  List<CardFood> items = [];

  getFirebaseData() async {
    List<CardFood> list = [];
    QuerySnapshot querySnapshot = await Firestore.instance.collection('products').getDocuments();
    for (DocumentSnapshot snapshot in querySnapshot.documents) {
      var data = snapshot.data;
      if (data['type'] == 'combo') {
        list.add(CardFood(data['name'], data['description'], data['image'], extra: data));
      }
    }
    setState(() {
      items = list;
    });
  }

  void showFood(data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShowFoodActivity(data),
      ),
    );
  }

  @override
  void initState() {
    getFirebaseData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.transparent,
      ),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          showFood(items[index].extra);
        },
        child: _cardFood(
          items[index].title,
          items[index].subtitle,
          items[index].image,
        ),
      ),
    );
  }

  // Widgets
  Widget _cardFood(String title, String subtitle, String image) {
    return Container(
      height: 250.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w700,
              shadows: [
                Shadow(
                  color: Colors.black,
                  blurRadius: 15,
                ),
              ],
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 20.0,
              shadows: [
                Shadow(color: Colors.black, blurRadius: 15),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(image),
        ),
      ),
    );
  }
}

class CardFood {
  String title;
  String subtitle;
  String image;
  dynamic extra;

  CardFood(this.title, this.subtitle, this.image, {this.extra});
}
