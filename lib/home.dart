import 'package:flutter/material.dart';
import 'package:pass_keep/components/FormComponet.dart';
import 'package:pass_keep/components/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        child: Column(
          
          children: [
            SizedBox(
              height: 5,
            ),
            
            SizedBox(height: 10,),
            PasswordCard(),
             PasswordCard(),
              PasswordCard(),
               PasswordCard(),
                PasswordCard(),
                 PasswordCard(),
                  PasswordCard(),
                   PasswordCard(),
          ],
        ),
      ),
    );
  }
}


