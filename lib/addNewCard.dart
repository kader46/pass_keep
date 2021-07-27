import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:direct_select/direct_select.dart';
import 'package:mysql1/mysql1.dart';
import 'package:pass_keep/accountModel.dart';
import 'package:pass_keep/dbhelper.dart';
import 'components/colors.dart';

class AddPass extends StatefulWidget {
  final DBHelper db;
  const AddPass({Key? key, required this.db}) : super(key: key);

  @override
  _AddPassState createState() => _AddPassState();
}

class _AddPassState extends State<AddPass> {
  int selctedIndex = 0;
  TextEditingController emailController = TextEditingController();
  bool mailValid = true;
  bool passwordVisible = false;
  TextEditingController passwordController = TextEditingController();
  var conn00;
  List<Widget> myList = [];
  final elements = [
    'facebook',
    'messenger',
    'instagram',
    'gmail',
    'telegram',
    'snapchat',
    'twitter',
    'whatsapp',
    'skype',
    'twitch',
    'discord',
    'spotify',
    'linkedin',
    'github',
    'dribbble',
    'dropbox',
    'vine',
    'vk',
    'other'
  ];

  List<Widget> _buildItems1() {
    return elements
        .map((val) => MySelectionItem(
              title: val,

            ))
        .toList();
  }

  @override
  void initState() {
    myList = _buildItems1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
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
            DirectSelect(
                mode: DirectSelectMode.tap,
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
                items: myList),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 5.0),
              child: Text(
                "Tap and Scroll",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                filled: true,
                fillColor: Colors.grey[100],
                labelText: 'Enter Email or Username',
                labelStyle: TextStyle(color: primaryColor),
              ),
            ),
            // Visibility(
            //     visible: mailValid,
            //     child: Text('Incorrect mail formamat',
            //         style: TextStyle(
            //             color: Colors.red,
            //             fontSize: 14,
            //             fontWeight: FontWeight.w500,
            //             fontStyle: FontStyle.italic))),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                filled: true,
                fillColor: Colors.grey[100],
                labelText: 'Enter Password',
                labelStyle: TextStyle(color: primaryColor),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                if (!mailValid ||
                    emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.LEFTSLIDE,
                    headerAnimationLoop: false,
                    dialogType: DialogType.ERROR,
                    title: 'ERROR ! ',
                    desc: 'Please check the incorrect fields ! ',
                  )..show();
                } else {
                  var aac = Account(
                      0,
                      emailController.text,
                      passwordController.text,
                      elements[selctedIndex].toString());
                      setState(() {
                        emailController.text='';
                        passwordController.text='';
                      });

                  widget.db.saveAccount(aac);

                  AwesomeDialog(
                    context: context,
                    animType: AnimType.LEFTSLIDE,
                    headerAnimationLoop: false,
                    dialogType: DialogType.SUCCES,
                    title: 'Done !',
                    desc:
                        'A ${elements[selctedIndex].toString()} account is added ',
                  )..show();
                }
              },
              child: Container(
                margin: EdgeInsets.all(15),
                height: 50,
                child: Center(
                    child: Text('Add To Vault ',
                        style: TextStyle(color: secendoryColor, fontSize: 20))),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  //color: primaryColor,
                  gradient: LinearGradient(colors: [forthColor, primaryColor]),
                ),
              ),
            ),
          ],
        ),
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
              child: _buildItem(context) ,
              
              padding: EdgeInsets.all(10.0),
            )
          : Card(
              //margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Stack(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'Assets/icons/social/png/$title.png',
                        height: 40,
                        width: 40,
                      ),
                      _buildItem(context),
                    ],
                  ),
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
          ),
          // Image.asset(
          //   'Assets/icons/social/png/$title.png',
          //   height: 40,
          //   width: 40,
          // ),
          SizedBox(
            width: 10,
          ),
          Text(
            title.replaceFirst(title[0], title[0].toUpperCase()),
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
