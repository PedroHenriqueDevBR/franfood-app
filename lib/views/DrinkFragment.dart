import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DrinkFragment extends StatefulWidget {
  List<CardFood> data;

  DrinkFragment({this.data});

  @override
  _DrinkFragmentState createState() => _DrinkFragmentState();
}

class _DrinkFragmentState extends State<DrinkFragment> with WidgetsBindingObserver {
  List<CardFood> items = [];

  getFirebaseData() async {
    List<CardFood> list = [];
    QuerySnapshot querySnapshot = await Firestore.instance.collection('products').getDocuments();
    for (DocumentSnapshot snapshot in querySnapshot.documents) {
      var data = snapshot.data;
      if (data['type'] == 'drink') {
        list.add(CardFood(data['name'], data['description'], data['image']));
      }
    }

    setState(() {
      items = list;
    });
  }

  @override
  void initState() {
    getFirebaseData();
    WidgetsBinding.instance.removeObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getFirebaseData();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.transparent,
      ),
      itemBuilder: (context, index) => _cardFood(
        items[index].title,
        items[index].subtitle,
        items[index].image,
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

  CardFood(this.title, this.subtitle, this.image);
}
