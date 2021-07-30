import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pass_keep/accountModel.dart';
import 'package:pass_keep/components/colors.dart';

import '../dbhelper.dart';

class PasswordCard extends StatefulWidget {
  final String id;
  final String socialApp;
  final String email;
  final String password;
  const PasswordCard({
    Key? key,
    required this.socialApp,
    required this.email,
    required this.password,
    required this.id,
  }) : super(key: key);

  @override
  _PasswordCardState createState() => _PasswordCardState();
}

class _PasswordCardState extends State<PasswordCard> {
 
  bool isObscure = true;
  bool changeMode = false;
  TextEditingController mailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  var db = DBHelper();
  @override
  void initState() {

    mailCon = TextEditingController(text: widget.email);
    passCon = TextEditingController(text: widget.password);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      shadowColor: primaryColor,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onDoubleTap: () {
                print('Enable chnage');
                setState(() {
                  changeMode = !changeMode;
                  if(!changeMode || isObscure==true) isObscure=!isObscure;

                });
              },
              child: Image.asset(
                'Assets/icons/social/png/${widget.socialApp}.png',
                width: 40,
                height: 40,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //  color: Colors.red,
                  margin: const EdgeInsets.all(0.0),
                  width: 180,
                  // height: 40,
                  child: TextFormField(
                    style: TextStyle(fontSize: 20),
                    controller: mailCon,
                    readOnly: !changeMode,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 0)),
                  ),
                ),
                Container(
                  width: 150,
                  //height: 30,
                  child: GestureDetector(
                    onLongPress: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    child: TextField(
                      controller: passCon,
                      obscureText: isObscure,
                      enabled: changeMode,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      // !isObscure
                      //     ? widget.password
                      //     : '${widget.password.replaceAll(RegExp(r"."), "*")}',
                      // style: TextStyle(color: primaryColor,fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            changeMode
                ? Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          int tempID = int.parse(widget.id);
                          var acc = Account(tempID, widget.email,
                              widget.password, widget.socialApp);

                          db.updateAccount(acc);
                          ScaffoldMessenger.of(context).showSnackBar(
                              new SnackBar(
                                  backgroundColor: secendoryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25))),
                                  width: 300,
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    'a Change in a ${widget.socialApp} account was made succesfully !',
                                    style: TextStyle(color: primaryColor),
                                  )));
                          setState(() {
                            changeMode = !changeMode;
                            isObscure = !isObscure;
                          });
                        },
                        icon: Icon(Icons.check),
                        color: Colors.green,
                      ),
                      IconButton(
                        onPressed: () {
                          int tempID = int.parse(widget.id);
                          var acc = Account(tempID, widget.email,
                              widget.password, widget.socialApp);
                          showAlertDialog(context, acc) ;
                          //db.deleteAccount(acc);
                          changeMode = !changeMode;
                          setState(() {
                            
                          });
                        },
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ],
                  )
                : IconButton(
                    onPressed: () {
                      Clipboard.setData(new ClipboardData(text: widget.email));
                      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                          action: SnackBarAction(
                              label: 'Password',
                              onPressed: () {
                                Clipboard.setData(
                                    new ClipboardData(text: widget.password));
                              }),
                          backgroundColor: secendoryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          width: 300,
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            '${widget.socialApp.replaceFirst(widget.socialApp[0], widget.socialApp[0].toUpperCase())}\'s Email is copied to ClipBoard !\nClick on Password to copy Password instead',
                            style: TextStyle(color: primaryColor),
                          )));
                    },
                    icon: Icon(Icons.copy)),
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context, Account acc) {
  // Create button

  Widget okButton = FlatButton(
    child: Text("Yes"),
    onPressed: () {
      var db = DBHelper();
      db.deleteAccount(acc);

      Navigator.of(context).pop();
    },
  );
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Warrning"),
    content: Text("Are you sure you want to delete this account"),
    actions: [okButton, cancelButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
