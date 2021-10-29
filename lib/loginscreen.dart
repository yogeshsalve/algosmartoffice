import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_attendance/dashboard.dart';
import 'package:smart_attendance/dashboard1.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  postData() async {
    var url = Uri.parse("http://algocenter.in/smartattd_api/login.php");
    var response = await http.post(url, body: {
      "username": nameController.text,
      "password": passwordController.text
    });

    var result = jsonDecode(response.body);
    print(result);

    if (result['error'] == "200") {
      if (result['user']['role'] == "ADMIN") {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Dashboard()));
      } else if (result['user']['role'] == "MANAGER") {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Dashboard1()));
      }
    } else if (result['error'] == "400") {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Alert'),
          content: const Text('Please enter correct username and password.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen())),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (result['error'] == "401") {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Alert'),
          content: const Text('User Does Not Exist'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen())),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Smart Attendance'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'ALGOSMART OFFICE',
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                // ignore: deprecated_member_use
                FlatButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  textColor: Colors.deepOrange,
                  child: Text('Forgot Password'),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.deepOrange,
                      child: Text('Login'),
                      onPressed: () {
                        postData();
                        // print(nameController.text);
                        // print(passwordController.text);
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Does not have account?'),
                    // ignore: deprecated_member_use
                    FlatButton(
                      textColor: Colors.deepOrange,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        //signup screen
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )),
                SizedBox(
                  height: 10.0,
                ),
                //---------------
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Login with Google'),
                      onPressed: () {
                        postData();
                        // print(nameController.text);
                        // print(passwordController.text);
                      },
                    )),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blueAccent,
                      child: Text('Login with Mate'),
                      onPressed: () {
                        postData();
                        // print(nameController.text);
                        // print(passwordController.text);
                      },
                    )),
              ],
            )));
  }
}
