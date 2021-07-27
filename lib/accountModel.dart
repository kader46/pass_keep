class Account {
  int? id;
  String? email;
  String? password;
  String? platform;

  Account(
    this.id,
    this.email,
    this.password,
    this.platform,
  );

  Account.fromMap(Map<dynamic, dynamic> map) {
    id = map[id];
    email = map[email];
    password = map[password];
    platform = map[platform];
  }
}
