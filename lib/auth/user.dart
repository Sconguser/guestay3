class User {
  String? email;
  String? password;
  String? bearerToken;
  String? name;
  String? lastName;
  String? username;
  int? id;

  User({this.email, this.password});
  User.fromJson(Map<String, dynamic> header, Map<String, dynamic> body) {
    bearerToken = header['authorization'];
    email = body['email'];
    name = body['name'];
    lastName = body['lastname'];
    username = body['username'];
    id = body['id'];
  }
}
