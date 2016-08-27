import 'address.model.dart';

class User {
  String id = "";
  String name = "";
  String gender = "";
  String department = "";
  Address address = new Address(null);

  Map fields;

  User(dynamic data){
    if (data != null) {
      fields = new Map.from(data);
      this.id = data['id'] ?? "";
      this.name = data['name'] ?? "";
      this.gender = data['gender'] ?? "";
      this.department = data['department'] ?? "";
      fields['address'] = this.address = new Address.fromJson(data['address']);
    }
  }

  factory User.fromJson(Map<String, dynamic> data) =>
      new User(data);
}
