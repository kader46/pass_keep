import 'package:flutter/material.dart';
import 'package:pass_keep/accountModel.dart';
import 'dart:async';

import 'package:pass_keep/dbhelper.dart';

Future<List<Account>> fetchEmployeesFromDatabase() async {
  var dbHelper = DBHelper();
  Future<List<Account>> accounts = dbHelper.getAccounts();
  return accounts;
}

class MyAccountsList extends StatefulWidget {
  const MyAccountsList({ Key? key }) : super(key: key);

  @override
  _MyAccountsListState createState() => _MyAccountsListState();
}

class _MyAccountsListState extends State<MyAccountsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          
          future: fetchEmployeesFromDatabase(),
          builder: (context, AsyncSnapshot<List<Account>> snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.toString().length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(snapshot.data![index].email.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text(snapshot.data![index].password.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                          new Divider()
                        ]
                  );
                }
                  
                );
            } else if (snapshot.hasError){
               return new Container(alignment: AlignmentDirectional.center,child: new CircularProgressIndicator(),);

            }
            return Container(
              child: Text('Something'),
            ) ;
        },
       
        ),
      ),
      
    );
  }
}