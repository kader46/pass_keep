import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pass_keep/components/colors.dart';

class PasswordCard extends StatelessWidget {
  final String socialApp ; 
  final String email ;
  final String password ;
  const PasswordCard({
    Key? key, required this.socialApp, required this.email, required this.password,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      shadowColor: primaryColor,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'Assets/icons/social/png/$socialApp.png',
              width: 50,
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  email,
                  style: TextStyle(color: primaryColor),
                ),
                Text(
                  password,
                  style: TextStyle(color: primaryColor),
                ),
              ],
            ),
            IconButton(onPressed: () {
               
                      Clipboard.setData(new ClipboardData(text: password));
                      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                          backgroundColor: secendoryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          width: 300,
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            '${socialApp.replaceFirst(socialApp[0], socialApp[0].toUpperCase())}\'s Password copied to ClipBoard !',
                            style: TextStyle(color: primaryColor),
                          )));
                    
            }, icon: Icon(Icons.copy))
          ],
        ),
      ),
    );
  }
}
