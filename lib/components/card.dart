import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class MyCard extends StatefulWidget {
   final String socialApp;
  final String email;
  final String password;
  const MyCard({ Key? key, required this.socialApp, required this.email, required this.password }) : super(key: key);

  @override
  _MyCardState createState() => _MyCardState();
}

 
  
 
class _MyCardState extends State<MyCard> {
   bool isObscure = true;
  TextEditingController mailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  @override
  void initState() {
   mailCon = TextEditingController(text: widget.email);
    passCon = TextEditingController(text: widget.password);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        
        child: Row(children: [
           Image.asset(
                'Assets/icons/social/png/${widget.socialApp}.png',
                width: 40,
                height: 40,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 150,
                    child: TextFormField()),
                  SizedBox(height: 5,),
                  Container(
                    width: 150,
                    child: TextFormField()),
                ],
              ),
                IconButton(
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
                            borderRadius: BorderRadius.all(Radius.circular(25))),
                        width: 300,
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          '${widget.socialApp.replaceFirst(widget.socialApp[0], widget.socialApp[0].toUpperCase())}\'s Email is copied to ClipBoard !\nClick on Password to copy Password instead',
                          style: TextStyle(color: primaryColor),
                        )));
                  },
                  icon: Icon(Icons.copy)),
        ],),
      ),
    );
  }
}