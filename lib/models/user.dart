class User {
  User(this.firstName, this.lastName, this.avatar);
  
  final String firstName;
  final String lastName;
  final String avatar;

  static User  fromJson(Map<String, dynamic> json) {
    final List<String> name = json['name'].split(' ');
    return User(
      name[0],
      name[1],
      json['avatar'] as String
    );
  }
}