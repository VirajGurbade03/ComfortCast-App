class UserModel {
  String? id; // Changed from final to nullable
  String email;
  String fullName;
  String password;
  int phoneNo;
  String dob;

  UserModel({
    this.id,
    required this.email,
    required this.fullName,
    required this.password,
    required this.phoneNo,
    required this.dob,
  });

  Map<String, dynamic> tojson() {
    return {
      'email': email,
      'fullName': fullName,
      'password': password,
      'phoneNo': phoneNo,
      'dob': dob,
    };
  }
}
