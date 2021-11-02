import 'dart:ui';
import 'package:Amit_Retail_App/item_compnenets/data_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Amit_Retail_App/item_compnenets/api_provider.dart';
import 'package:Amit_Retail_App/item_compnenets/data_model.dart';
import 'package:Amit_Retail_App/item_details.dart';


class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ApiProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyCartPage(title: ''),
      ),
    );
  }
}

class MyCartPage extends StatefulWidget {
  MyCartPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  Future future;
  TextEditingController controller = TextEditingController();

  Dio dio = Dio();
  ApiProvider cartProvider = ApiProvider();
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

  @override
  void initState() {
    super.initState();
    future = Provider.of<ApiProvider>(context, listen: false).getData();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }


  /// CallBacks => With Futures

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError)
                return Center(child: Text(snapshot.error.toString()));
              else
                return  Consumer<ApiProvider>(
                  builder: (context, cartProvider, child) {
                    List<Products> cartItems = [
                      cartProvider.dataModel.products[2],
                      cartProvider.dataModel.products[5],
                      cartProvider.dataModel.products[14],
                    ];
                    return ListView.builder(
                      // Let the ListView know how many items it needs to build.
                        itemCount: cartItems.length,
                        // Provide a builder function. This is where the magic happens.
                        // Convert each item into a widget based on the type of item it is.
                        itemBuilder: (context, index) {
                          return Container(
                           height: 150,
                            child:Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Image.network(
                                        cartItems[index].avatar,
                                        width: 80,
                                        height: 100,
                                      ),

                                     Padding(
                                       padding: const EdgeInsets.only(left: 30.0),
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text(
                                             cartItems[index].title,
                                             style: TextStyle(
                                                 color: Colors.black, fontSize: 16),
                                             maxLines: 2,
                                           ),


                                             Text(
                                               cartItems[index].name,
                                               overflow: TextOverflow.ellipsis,
                                               maxLines: 2,
                                               style: TextStyle( fontSize:12,color: Colors.grey),
                                             ),
                                           SizedBox(height: 20,),
                                          Row(
                                             children:[ Text(
                                               cartItems[index].price_final_text,
                                               style: TextStyle(
                                                   color: Colors.red, fontSize: 16),
                                               maxLines: 2,
                                             ),
                                               SizedBox(width: 50.0),
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

                                           ],),


                                         ],
                                       ),
                                     ),


                                    ],

                                  ),
                                ),

                              ],

                            ),
                          );
                        });

                  } );





          }
        },
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left:40.0),
          child: Row(
            children: [FlatButton(
              minWidth: 150,
              height: 50,
              hoverColor: Colors.black38,
              color: Colors.white,
              shape: RoundedRectangleBorder(side: BorderSide(
                  color: Colors.grey,
                  width: 1,
                  style: BorderStyle.solid
              )),
              child: Text('Clear Cart',style: TextStyle(fontSize: 14,color: Colors.black),),
              onPressed: () {},
            ),
              SizedBox(width: 10,),
              FlatButton(
                minWidth: 150,
                height: 50,
                hoverColor: Colors.black38,


                color: Colors.red,
                child: Text('Go To Checkout',style: TextStyle(fontSize: 14,color: Colors.white),),
                onPressed: () {},
              ),
          ],),
        ),
      ),
    );

  }

}