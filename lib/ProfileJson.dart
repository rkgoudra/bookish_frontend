class ProfileJson{
  String id, fname,lname, gender, phone, email, photo;
  ProfileJson(
      this.id,
      this.fname,
      this.lname,
      this.gender,
      this.phone,
      this.email,
      this.photo,
      );
  ProfileJson.fromJson(Map<String, dynamic> json) {
    id = json['user_id'];
    fname = json['user_name'];
    lname = json['last_name'];
    gender = json['gender'];
    phone = json['phno'];
    email = json['email'];
    photo = json['profile_pic'];
  }
}