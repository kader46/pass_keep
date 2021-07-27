import 'package:pass_keep/accountModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io' as io;

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "test.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE Accounts(id INTEGER PRIMARY KEY, email TEXT, password TEXT, platform TEXT)");
    print("Created tables");
  }

  void saveAccount(Account account) async {
    var dbClient = await db;
    await dbClient!.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO Accounts(email, password, platform) VALUES(?,?,?)', [
        account.email.toString(),
        account.password.toString(),
        account.platform.toString()
      ]);
    });
  }

  void updateAccount(Account acc) async {
     var dbClient = await db;
     await dbClient!.rawUpdate( 'UPDATE Accounts SET email = ?, password = ? WHERE id = ?',
    [acc.email.toString(), acc.password.toString(), acc.id.toString()]) ;

  }
  void deleteAccount(Account acc) async {
    var dbClient = await db;
    await dbClient!.rawDelete('DELETE FROM Accounts WHERE id = ?', [acc.id.toString()]) ;
  }

  Future<List<Account>> getAccounts() async {
    var dbClient = await db;
    List<Map> list = await dbClient!.rawQuery('SELECT * FROM Accounts');

    List<Account> accounts = [];
    for (int i = 0; i < list.length; i++) {
      accounts.add(new Account(list[i]["id"], list[i]["email"],
          list[i]["password"], list[i]["platform"]));
    }
    print(accounts.length);
    return accounts;
  }
}
