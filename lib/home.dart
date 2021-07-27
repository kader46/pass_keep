import 'package:flutter/material.dart';
import 'package:pass_keep/accountList.dart';
import 'package:pass_keep/accountModel.dart';
import 'package:pass_keep/components/FormComponet.dart';
import 'package:pass_keep/components/card.dart';
import 'package:pass_keep/components/colors.dart';

import 'dbhelper.dart';

class Home extends StatefulWidget {
  final DBHelper dbHelper;
  const Home({Key? key, required this.dbHelper}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Future<List<Account>> fetchEmployeesFromDatabase(DBHelper dbHelper) async {
    //var dbHelper = DBHelper();
    Future<List<Account>> accounts = dbHelper.getAccounts();
    return accounts;
  }

  List<Widget> returnedList = [];
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            Text(
              'My Password List',
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),

            FutureBuilder(
              future: fetchEmployeesFromDatabase(widget.dbHelper),
              builder: (context, AsyncSnapshot<List<Account>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.length == 0) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Image.asset('Assets/img/404.png'),
                      ],
                    );
                  } else
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) {
                          print(snapshot.data![i].platform.toString());
                          return 
                         
                          PasswordCard(
                              id: snapshot.data![i].id.toString(),
                              socialApp: snapshot.data![i].platform.toString(),
                              email: snapshot.data![i].email.toString(),
                              password: snapshot.data![i].password.toString());
                        });

                  // return Text('Data kyna ');
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

               else return CircularProgressIndicator(
                 color: primaryColor,
               );
              },
            ),

            // PasswordCard(
            //   socialApp: 'facebook',
            //   password: '*********************',
            //   email: 'user1@gmail.com',
            // ),
            // PasswordCard(
            //   socialApp: 'instagram',
            //   password: '********************',
            //   email: 'mymail123@gmail.com',
            // ),
            // PasswordCard(
            //   socialApp: 'messenger',
            //   password: '********************',
            //   email: 'mymail123@gmail.com',
            // ),
            // PasswordCard(
            //   socialApp: 'twitter-1',
            //   password: '*************************',
            //   email: 'twitteraccount@gmail.com',
            // ),
            // PasswordCard(
            //   socialApp: 'skype',
            //   password: '****************',
            //   email: 'sauce46@gmail.com',
            // ),
            // PasswordCard(
            //   socialApp: 'whatsapp',
            //   password: '*****************',
            //   email: '(+213)056605605506',
            // ),
            // PasswordCard(
            //   socialApp: 'github',
            //   password: '****************',
            //   email: 'kader46',
            // ),
          ],
        ),
      ),
    );
  }
}
