import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api_provider.dart';
import 'data_model.dart';
import 'package:Amit_Retail_App/item_details.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ApiProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: ''),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future future;
  TextEditingController controller = TextEditingController();

  Dio dio = Dio();
  ApiProvider provider = ApiProvider();

  List<Products> products;
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
                  builder: (context, provider, child)
                  {
                    return GridView.count(
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                      crossAxisCount: 2,
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(provider.dataModel.products.length, (index) {
                        return  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(width: 20.0),
                              Expanded(
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => DetailScreen(product: provider.dataModel.products[index])),
                                    );
                                  },
                                  child: Hero(tag: "${provider.dataModel.products[index].id}",
                                    child: Image.network(
                                      provider.dataModel.products[index].avatar,
                                      fit: BoxFit.cover,
                                    ),),

                                ),
                              ),
                              Text(
                                provider.dataModel.products[index].title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle( fontSize:14, color: Colors.black),
                              ),
                              Text(
                                provider.dataModel.products[index].name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle( fontSize:12,color: Colors.grey, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 30.0),

                              Row(
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: (){},
                                    child: new Icon(Icons.add, color: Colors.white,),
                                    minWidth: 0,
                                    height: 1,
                                    hoverColor: Colors.black38,
                                    color: Colors.red,),
                                  RichText(

                                    text: TextSpan(
                                      children: [

                                        WidgetSpan(
                                          child: Container(

                                            padding: EdgeInsets.only(left: 30),

                                            child:  Text( "${provider.dataModel.products[index].price_final_text}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.red, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              )
                            ],
                          ),
                        )
                        ;
                      }),

                    );

                  },
                );
          }
        },
      ),

    );

  }
}
/*
 List.generate(provider.dataModel.products.length, (index) {

              return Center(
              child: Image.network(provider.dataModel.products[index].avatar),

              );
              ///////
              child:  TextField(
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                            hintText: provider.dataModel.products[index].title,
                            border: InputBorder.none,

                          ),
                        ),
                        ///////////////////////////////////
                           ListTile(
                              title: Text(provider.dataModel.products[index].title),
                              subtitle: Text(provider.dataModel.products[index].name),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[

                                const SizedBox(width: 8),
                                TextButton(
                                  child: Text(provider.dataModel.products[index].price_final_text,),
                                  onPressed: () {/* ... */},
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
 */

/*
 tabs: [
          ScrollableListTab(
              tab: ListTab(label: Text('Label 1'), icon: Icon(Icons.group)),
              body: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (_, index) => ListTile(
                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                    alignment: Alignment.center,
                    child: Text(index.toString()),
                  ),
                  title: Text('List element $index'),
                ),
              )),
        ],
 */