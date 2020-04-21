import 'package:flutter/material.dart';

class FoodFragment extends StatefulWidget {
  @override
  _FoodFragmentState createState() => _FoodFragmentState();
}

class _FoodFragmentState extends State<FoodFragment> {
  /*
  List<CardFood> items = [
    CardFood(
      'Bomba',
      'Bomba de presunto e queijo',
      'https://images.pexels.com/photos/41967/appetizer-canape-canapes-cheese-41967.jpeg',
    ),
    CardFood(
      'Bomba',
      'Bomba de presunto e queijo',
      'https://images.pexels.com/photos/1633578/pexels-photo-1633578.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    ),
    CardFood(
      'Bomba',
      'Bomba de presunto e queijo',
      'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    ),
    CardFood(
      'Bomba',
      'Bomba de presunto e queijo',
      'https://images.pexels.com/photos/461198/pexels-photo-461198.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    ),
  ];
  [
   */
  List<CardFood> items = [
    CardFood(
      'Bomba',
      'Bomba de presunto e queijo',
      'https://images.pexels.com/photos/1633578/pexels-photo-1633578.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    ),
  ];

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
}

class CardFood {
  String title;
  String subtitle;
  String image;

  CardFood(this.title, this.subtitle, this.image);
}
