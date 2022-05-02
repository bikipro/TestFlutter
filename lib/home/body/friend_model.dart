// ignore_for_file: prefer_initializing_formals, duplicate_ignore

class FriendModel {
  String id = "", name = "", email = "", profile = "", number = "";
  // ignore: duplicate_ignore
  FriendModel(
      [String id = "",
      String name = " ",
      String email = "",
      String profile = "",
      String number = ""]) {
    // ignore: prefer_initializing_formals
    this.id = id;
    this.name = name;
    this.email = email;
    this.profile = profile;
    this.number = number;
  }

  FriendModel fromMap(Map<String, dynamic> map) {
    return FriendModel(map['name'], map['email'], map['profile']);
  }
}
