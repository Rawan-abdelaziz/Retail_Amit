

import 'package:flutter/material.dart';
import 'package:Amit_Retail_App/item_compnenets/data_model.dart';
import 'package:flutter_cart/flutter_cart.dart';

/// This is the main application widget.
class DetailScreen extends StatefulWidget {
  const DetailScreen({Key key, this.product}) : super(key: key);
  final Products product;

  @override
  _DetailScreenState createState() => _DetailScreenState(product);
}
class _DetailScreenState extends State<DetailScreen>  {
  _DetailScreenState(this.product);
  int _n = 0;

  void add() {
    setState(() {
      _n++;
    });
  }
  void minus() {
    setState(() {
      if (_n != 0)
        _n--;
    });
  }
  // In the constructor, require a Todo.
  final Products product;

  // Declare a field that holds the Todo.


  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Image.network(
            product.avatar,
            fit: BoxFit.cover,
          ),

              Text(
               product.title,

                style: TextStyle( fontSize:20, color: Colors.black,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Text(
                product.name,

                style: TextStyle( fontSize:18, color: Colors.black),
              ),
              Divider(
                thickness: 2,
                  color: Colors.black
              ),
              SizedBox(height: 10.0),

              Container(
                child: Row(
                  children: [
                Text( product.price_final_text,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.red, fontWeight: FontWeight.bold),
                ),
                    SizedBox(width: 150.0),
                    FlatButton(
                      onPressed: add,
                      child: new Icon(Icons.add, color: Colors.white,),
                      minWidth: 1,
                      height: 1,
                      hoverColor: Colors.black38,
                      color: Colors.red,),
                    SizedBox(width: 5),
                    Text('$_n',
                        style: new TextStyle(color:Colors.red,fontSize: 20.0)),
                    SizedBox(width: 5),
                    FlatButton(
                      onPressed: minus,
                      child: new Icon(Icons.remove, color: Colors.white,),
                        minWidth: 1,
                        height: 1,
                        hoverColor: Colors.black38,
                        color: Colors.red,),
             ], ),
              ),


              SizedBox(height: 20.0),
              Divider(
                  thickness: 2,
                  color: Colors.black
              ),
              SizedBox(height: 5.0),
              Text(
                product.description.toString(),

                style: TextStyle( fontSize:17, color: Colors.black),
              ),
              SizedBox(height: 80.0),

               FlatButton(
                  onPressed: () {


                  },
   minWidth: 800,
                  height: 50,
                  hoverColor: Colors.black38,
                  color: Colors.red,
                  child: Text("Add To Cart", style: TextStyle(fontSize:18,color: Colors.white)),

                ),



      ],),
        )

    ),
    );
  }


}

