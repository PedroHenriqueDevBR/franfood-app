import 'package:flutter/material.dart';

class ShowFoodActivity extends StatefulWidget {

  var data;

  ShowFoodActivity(this.data);

  @override
  _ShowFoodActivityState createState() => _ShowFoodActivityState();
}

class _ShowFoodActivityState extends State<ShowFoodActivity> {

  String type;

  void selectType() {
    if (widget.data['type'] == 'food') {
      type = 'lanche';
    } else if (widget.data['type'] == 'drink') {
      type = 'Bebida';
    } else if (widget.data['image'] == 'combo') {
      type = 'Combo';
    }
  }

  void formatPrice() {
    String res;
    double aux = double.parse(widget.data['price']);
    res = aux.toStringAsFixed(2);
    widget.data['price'] = res;
  }

  @override
  Widget build(BuildContext context) {
    selectType();
    formatPrice();
    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    return CustomScrollView(
      slivers: <Widget>[
        appBar(),
        content(),
      ],
    );
  }

  SliverFillRemaining content() {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Preço: R\$ ${widget.data['price']}",
                  style: TextStyle(
                      fontSize: 20,
                    fontFamily: 'verdana'
                  ),
                ),
                Text("Tipo: ${type}",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'verdana'
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(30),
              child: Text(
                  widget.data['description'],
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'verdana',
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  wordSpacing: 2,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar appBar() {
    return SliverAppBar(
      pinned: true,
      snap: false,
      floating: false,
      expandedHeight: MediaQuery.of(context).size.height / 3,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
            widget.data['name'],
            style: TextStyle(
              shadows: [
                Shadow(
                  color: Colors.black,
                  blurRadius: 15,
                ),
              ],
            ),
        ),
        background: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(widget.data['image']),
            ),
          ),
        ),
      ),
    );
  }

}
