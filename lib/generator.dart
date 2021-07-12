import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pass_keep/components/colors.dart';
import 'package:random_password_generator/random_password_generator.dart';

class GeneratorPage extends StatefulWidget {
  @override
  _GeneratorPageState createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  bool _isWithLetters = true;
  bool _isWithUppercase = false;
  bool _isWithNumbers = false;
  bool _isWithSpecial = false;
  double _numberCharPassword = 8;
  String newPassword = '';
  Color _color = Colors.blue;
  String isOk = '';
  TextEditingController carNum = TextEditingController();
  TextEditingController _passwordLength = TextEditingController();
  final password = RandomPasswordGenerator();
  @override
  void initState() {
    super.initState();
  }

  checkBox(String name, Function onTap, bool value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(name),
        Checkbox(
            value: value,
            onChanged: (value) {
              onTap();
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Password Generator',
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Text('Upper Case'),
                    Checkbox(
                        value: _isWithUppercase,
                        checkColor: secendoryColor,
                        fillColor: MaterialStateProperty.all(primaryColor),
                        onChanged: (value) {
                          setState(() {
                            _isWithUppercase = value!;
                          });
                        }),
                  ],
                ),
                Row(
                  children: [
                    Text('Lower Case'),
                    Checkbox(
                        value: _isWithLetters,
                        checkColor: secendoryColor,
                        fillColor: MaterialStateProperty.all(primaryColor),
                        onChanged: (value) {
                          setState(() {
                            _isWithLetters = value!;
                          });
                        }),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Text('    Symbols'),
                    Checkbox(
                        value: _isWithSpecial,
                        checkColor: secendoryColor,
                        fillColor: MaterialStateProperty.all(primaryColor),
                        onChanged: (value) {
                          setState(() {
                            _isWithSpecial = value!;
                          });
                        }),
                  ],
                ),
                Row(
                  children: [
                    Text('   Numbers'),
                    Checkbox(
                        value: _isWithNumbers,
                        checkColor: secendoryColor,
                        fillColor: MaterialStateProperty.all(primaryColor),
                        onChanged: (value) {
                          setState(() {
                            _isWithNumbers = value!;
                          });
                        }),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
           
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
                style: TextStyle(
                    color: primaryColor, fontSize: 24, ),
                controller: _passwordLength,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  labelText: 'Enter Length',
                  labelStyle: TextStyle(color: primaryColor),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            FlatButton(
                onPressed: () {
                  if (_passwordLength.text.trim().isNotEmpty)
                    _numberCharPassword =
                        double.parse(_passwordLength.text.trim());

                  newPassword = password.randomPassword(
                      letters: _isWithLetters,
                      numbers: _isWithNumbers,
                      passwordLength: _numberCharPassword,
                      specialChar: _isWithSpecial,
                      uppercase: _isWithUppercase);

                  print(newPassword);
                  double passwordstrength =
                      password.checkPassword(password: newPassword);
                  if (passwordstrength < 0.3) {
                    _color = Colors.red;
                    isOk = 'This password is weak!';
                  } else if (passwordstrength < 0.7) {
                    _color = Colors.blue;
                    isOk = 'This password is Good';
                  } else {
                    _color = Colors.green;
                    isOk = 'This passsword is Strong';
                  }

                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.all(15),
                  height: 50,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    //color: primaryColor,
                    gradient:
                        LinearGradient(colors: [forthColor, primaryColor]),
                  ),
                  //  color: primaryColor,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Generate a Password',
                        style: TextStyle(color: secendoryColor, fontSize: 20),
                      ),
                    ),
                  ),
                )),

            if (newPassword.isNotEmpty && newPassword != null)
              Center(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    isOk,
                    style: TextStyle(color: _color, fontSize: 14),
                  ),
                ),
              )),
            if (newPassword.isNotEmpty && newPassword != null)
              Center(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onLongPress: () {
                      print(newPassword);
                      Clipboard.setData(new ClipboardData(text: newPassword));
                      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                          backgroundColor: secendoryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          width: 230,
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            'Password copied to ClipBoard !',
                            style: TextStyle(color: primaryColor),
                          )));
                    },
                    child: Text(
                      newPassword,
                      style: TextStyle(color: forthColor, fontSize: 25),
                    ),
                  ),
                ),
              ))
          ],
        )),
      ),
    );
  }
}
