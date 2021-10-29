import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_attendance/loginscreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String dropdownValue = 'USER';
  bool _obscureText = true;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();
  TextEditingController controller7 = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  // ignore: non_constant_identifier_names
  Signup() async {
    var url = Uri.parse("http://www.algocenter.in/smartattd_api/register.php");
    var response = await http.post(url, body: {
      "username": controller1.text,
      "password": controller6.text,
      "email": controller2.text,
      "gender": controller3.text,
      "dob": controller5.text,
      "contactno": controller4.text,
      "role": controller7.text,
    });

    var result = jsonDecode(response.body);
    print(result);
    print(response.statusCode);

    if (result['error'] == "200") {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Alert'),
          content: const Text('Register successful!'),
          actions: <Widget>[
            // TextButton(
            //   onPressed: () => Navigator.pop(context, 'Cancel'),
            //   child: const Text('Cancel'),
            // ),
            TextButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen())),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (result['error'] == "403") {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Alert'),
          content: const Text('User Already Exist'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterScreen())),
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
          title: Text('AlgoSmart'),
        ),
        body: Scrollbar(
          thickness: 5,
          isAlwaysShown: true,
          radius: Radius.circular(10),
          child: Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 25.0,
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
                        'Register Here',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: controller1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: controller2,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: controller3,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Gender',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      obscureText: _obscureText,
                      keyboardType: TextInputType.number,
                      controller: controller4,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Contact',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: controller5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'DOB',
                      ),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: controller7
                          ..text = dropdownValue.toString(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Role',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['USER', 'MANAGER', 'ADMIN']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: true,
                      controller: controller6,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.deepOrange,
                        child: Text('Register'),
                        onPressed: () {
                          //postData();
                          Signup();
                        },
                      )),
                  SizedBox(
                    height: 50.0,
                  ),
                ],
              )),
        ));
  }
}
