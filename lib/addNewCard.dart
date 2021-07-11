import 'package:flutter/material.dart';

import 'components/colors.dart';


class AddPass extends StatefulWidget {
  const AddPass({ Key? key }) : super(key: key);

  @override
  _AddPassState createState() => _AddPassState();
}

class _AddPassState extends State<AddPass> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 5,),
           Text(
              'Add New Element',
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            

        ],
      ),
      
    );
  }
}