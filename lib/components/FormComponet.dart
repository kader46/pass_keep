import 'package:flutter/material.dart';
import 'package:pass_keep/components/colors.dart';

class PasswordCard extends StatelessWidget {
  const PasswordCard({
    Key? key,
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
              'Assets/icons/social/png/045-facebook.png',
              width: 50,
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'emailhere@gmail.com ',
                  style: TextStyle(color: primaryColor),
                ),
                Text(
                  '*******************',
                  style: TextStyle(color: primaryColor),
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.copy))
          ],
        ),
      ),
    );
  }
}
