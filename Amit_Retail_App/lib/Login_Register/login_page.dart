import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Amit_Retail_App/Login_Register/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Bottom_NavBar.dart';





class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isLoading = false;
  var errorMsg;
  bool _passwordVisible;
  final TextEditingController mobileController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  @override
  void initState() {
    _passwordVisible = false;
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Container(
        color: Colors.white,

        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: _isLoading ? Center(child: CircularProgressIndicator()) : ListView(
            children: <Widget>[
              SizedBox(height: 100.0,
                  child:Image(image: NetworkImage('https://www.amit-learning.com/assets/logo.png'),)),
              SizedBox(height: 30.0),
              TextFormField(
                controller: mobileController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: "Email",
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))
                ),
              ),
              SizedBox(height: 30.0),
              TextFormField(
                controller: passwordController,
                obscureText: !_passwordVisible,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12.0),
                    hintText: "Password",
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 50.0),
              RaisedButton(
                onPressed: () {
                  print("Login pressed");
                  setState(() {
                    _isLoading = true;
                  });
                  signIn(mobileController.text, passwordController.text);


                },
                child: Text("Log In", style: TextStyle(color: Colors.white)),
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                color: Colors.red,
                splashColor: Colors.blue,
                textColor: Colors.white,
              ),
              errorMsg == null? Container(): Text(
                "${errorMsg}",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20,),
              Text(
                'Not have an account? Create one,,,',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => RegisterPage()), (Route<dynamic> route) => false);
                },
                elevation: 0.0,
                color: Colors.red,
                child: Text("Go SignUp", style: TextStyle(color: Colors.white70)),
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
              ),
            ],
          ),
        ),),
    );
  }

  signIn(String mobile, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'email': mobile,
      'password': pass
    };
    var jsonResponse ;
    var response = await http.post("https://retail.amit-learning.com/api/login", body: data);
    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if(jsonResponse != null) {
        setState(() {
          _isLoading = false;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BottomBar()),
          );
        });
        sharedPreferences.setString("token", jsonResponse['data']['token']);

        //  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => BottomBar()), (Route<dynamic> route) => false);
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      errorMsg = response.body;
      print("The error message is: ${response.body}");
    }
  }

}