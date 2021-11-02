import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_list_tabview/scrollable_list_tabview.dart';

import 'api_provider_categories.dart';


class CategoriesScreen extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder(

        future: future,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError)
                return Center(child: Text('Data Not Found'));
              else
                return  Consumer<ApiProvider>(
                  builder: (context, provider, child)
                  {
                    return GridView.count(
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                      crossAxisCount: 2,

                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(provider.dataModel.categories.length, (index) {
                        return Stack(

                          children:[

                            Image.network( provider.dataModel.categories[index].avatar,
                              width: 200,),
                            ClipRRect( // Clip it cleanly.
                              child: BackdropFilter(

                                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),

                                child: Container(
                                  color: Colors.grey.withOpacity(0.1),
                                  alignment: Alignment.center,
                                  child: Text('${provider.dataModel.categories[index].name}',
                                      style: TextStyle(fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        backgroundColor:Colors.black38,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ),
                          ],

                        );
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
Image.network( provider.dataModel.categories[index].avatar,
                                            width: 150,),
                                          ClipRRect( // Clip it cleanly.
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                              child: Container(
                                                color: Colors.grey.withOpacity(0.1),
                                                alignment: Alignment.center,
                                                child: Text('${provider.dataModel.categories[index].name}',
                                                    style: TextStyle(fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                      backgroundColor:Colors.black26,
                                                      color: Colors.white,
                                                    )),
                                              ),
                                            ),
                                          ),
 */