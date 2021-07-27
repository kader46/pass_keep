import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:pass_keep/accountList.dart';
import 'package:pass_keep/addNewCard.dart';
import 'package:pass_keep/components/colors.dart';
import 'package:pass_keep/dbhelper.dart';
import 'package:pass_keep/generator.dart';
import 'package:pass_keep/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  var db = DBHelper();
 
  int currencetIndex = 1;

  int a = 15 ;
  PageController pageIndex = PageController(initialPage: 1);
  @override
  void initState() {
    db.initDb() ;
    db.getAccounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
            elevation: 0,
            toolbarHeight: 120,
            backgroundColor: Colors.white,
            title: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Password Vault',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 45,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Keep your passwords safe in one App ',
                  style: TextStyle(fontSize: 14, color: forthColor),
                ),
                Divider(
                  color: primaryColor,
                ),
              ],
            )),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.floating,
        elevation: 15,
        padding: EdgeInsets.all(15),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        snakeShape: SnakeShape.circle,
        backgroundColor: primaryColor,
        unselectedItemColor: secendoryColor,
        selectedItemColor: forthColor,
        currentIndex: currencetIndex,
        snakeViewColor: thirdColor,
        onTap: (valueSelcted) {
          setState(() {
            
            currencetIndex = valueSelcted;
            // pageIndex.jumpToPage(valueSelcted) ;
            pageIndex.animateToPage(valueSelcted,
                duration: Duration(seconds: 1), curve: Curves.ease);
          });
        },
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.gesture), label: 'Generate'),
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14, color: Colors.white),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
      body: SafeArea(
        child: PageView(
          
          controller: pageIndex,
          onPageChanged: (PageSelcted) {
            setState(() {
              currencetIndex = PageSelcted;
            });
          },
          children: [
            AddPass(db: db,),
            Home(dbHelper: db,),
            GeneratorPage(),
          ],
        ),
      ),
    );
  }
}
