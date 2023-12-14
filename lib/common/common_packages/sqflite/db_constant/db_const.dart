class DBConst {
  static const databaseName = "user.db";
  static const tableName = "userData";
  static const version = 1;
  static const columnId = "id";
  static const columnName = "name";
  static const columnEmail = "email";
  static const columnMobile = "mobile";

  static const idType = "INTEGER PRIMARY KEY AUTOINCREMENT"; //AUTOINCREMENT OPTIONAL
  static const textType = "TEXT";

  static const tableNameUserLogin = "userLogin";
  static var columIsLogIn = 'is_login';
}

class UserLocalData {
  String? columnId;
  String? columnName;
  String? columnEmail;
  String? columnMobile;

  UserLocalData({
    this.columnId,
    this.columnName,
    this.columnEmail,
    this.columnMobile,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[DBConst.columnId] = columnId;
    data[DBConst.columnName] = columnName;
    data[DBConst.columnEmail] = columnEmail;
    data[DBConst.columnMobile] = columnMobile;
    return data;
  }
}
