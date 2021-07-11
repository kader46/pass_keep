import 'package:flutter/material.dart';
import 'package:direct_select/direct_select.dart';
import 'components/colors.dart';

class AddPass extends StatefulWidget {
  const AddPass({Key? key}) : super(key: key);

  @override
  _AddPassState createState() => _AddPassState();
}

class _AddPassState extends State<AddPass> {
  int selctedIndex = 0;
  final elements = [
    'facebook',
    'messenger',
    'instagram',
    'skype',
    'snapchat',
    'twitter-1',
    'whatsapp',
    'twitch',
    'github',
  ];
  List<Widget> _buildItems1() {
    return elements
        .map((val) => MySelectionItem(
              title: val,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Text(
            'Add New Element',
            style: TextStyle(
                color: primaryColor, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          DirectSelect(
              itemExtent: 50.0,
              selectedIndex: selctedIndex,
              backgroundColor: Colors.white,
              child: MySelectionItem(
                isForList: false,
                title: elements[selctedIndex],
              ),
              onSelectedItemChanged: (index) {
                setState(() {
                  selctedIndex = index!;
                });
              },
              items: _buildItems1()),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 5.0),
            child: Text(
              "Long press and scroll",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ),
          
        ],
      ),
    );
  }
}

class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;

  const MySelectionItem({Key? key, required this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: isForList
          ? Padding(
              child: _buildItem(context),
              padding: EdgeInsets.all(10.0),
            )
          : Card(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Stack(
                children: <Widget>[
                  _buildItem(context),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ),
    );
  }

  _buildItem(BuildContext context) {
    return Container(
      width: 200, //MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'Assets/icons/social/png/$title.png',
            height: 40,
            width: 40,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(
                color: primaryColor, 
                fontSize: 24, 
                fontWeight: FontWeight.bold,
                
                ),
          ),
        ],
      ),
    );
  }
}
