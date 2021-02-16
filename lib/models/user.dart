class ModelUser {
  bool status;
  String message;
  User user;

  ModelUser({this.status, this.message, this.user});

  ModelUser.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['data'] != null ? new User.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['data'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  String sId;
  String role;
  String resetPasswordLink;
  String username;
  String fullname;
  String email;
  String phone;
  String createdAt;
  String updatedAt;

  User(
      {this.sId,
      this.role,
      this.resetPasswordLink,
      this.username,
      this.fullname,
      this.email,
      this.phone,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    role = json['role'];
    resetPasswordLink = json['resetPasswordLink'];
    username = json['username'];
    fullname = json['fullname'];
    email = json['email'];
    phone = json['phone'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['role'] = this.role;
    data['resetPasswordLink'] = this.resetPasswordLink;
    data['username'] = this.username;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
