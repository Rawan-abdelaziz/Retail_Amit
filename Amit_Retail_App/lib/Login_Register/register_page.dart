import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Bottom_NavBar.dart';
import 'login_page.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  bool _isLoading = false;
  bool _passwordVisible;
  var errorMsg;
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
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
                controller: emailController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: "Email",
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))
                ),
              ),
              SizedBox(height: 30.0),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: "Name",
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
                  print("SignUP pressed");
                  setState(() {
                    _isLoading = true;
                  });
                  signUP(nameController.text,emailController.text, passwordController.text);


                },
                child: Text("Sign UP", style: TextStyle(color: Colors.white)),
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
                ' have an account? ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
                },
                elevation: 0.0,
                color: Colors.red,
                child: Text("Go Login", style: TextStyle(color: Colors.white70)),
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
              ),
            ],
          ),
        ),),
    );
  }

  signUP(String name, email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'name': name,
      'email': email,
      'password': pass
    };
    var jsonResponse ;
    var response = await http.post("https://retail.amit-learning.com/api/register", body: data);
    print(response.statusCode);
    if(response.statusCode == 201) {
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