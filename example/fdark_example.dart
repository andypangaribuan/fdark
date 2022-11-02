import 'package:fdark/fdark.dart';
import 'package:fdation/fdation.dart';

final FDB db = FPostgresDB(
  host: '127.0.0.1',
  port: 5432,
  name: 'fdark',
  user: 'postgres',
  password: 'postgres',
  scheme: 'public',
  settings: FConnectionSettings(
    maxIdle: 2,
    maxOpen: 10,
    lifetime: Duration(minutes: 30),
  ),
);

void main() async {
  final rows = await db.query('SELECT * FROM users WHERE email=@email', pars: {
    'email': 'iam.pangaribuan@gmail.com',
  });

  final users = rows.loopToList((row) => User.fromRow(row));
  for (final user in users) {
    print(user.name);
  }
}


class User extends FJsonSerializable {
  int id;
  String name;
  String email;
  int? idNumber;
  bool isActive;
  bool isFirstLogin;
  DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.idNumber,
    required this.isActive,
    required this.isFirstLogin,
    required this.createdAt,
  });

  factory User.fromRow(FDBRow row) {
    return User(
      id: row['id'],
      name: row.get('name')!,
      email: row['email'],
      idNumber: row.get('id_number'),
      isActive: row['is_active'],
      isFirstLogin: row.get('firstLogin')!,
      createdAt: row.get('created_at'),
    );
  }

  @override
  Map<String, dynamic> serialize() {
    final keys = <String>[];
    return omitempty(keys, {
      'id': id,
      'name': name,
      'email': email,
      'idNumber': idNumber,
      'isActive': isActive,
      'isFirstLogin': isFirstLogin,
      'createdAt': createdAt,
    });
  }
}
