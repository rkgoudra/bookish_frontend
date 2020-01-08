class AddBookJson {
  int status;
  String gener_id, message, gener_name;

  AddBookJson(
      this.gener_id,
      this.message,
      this.gener_name,
      );

  AddBookJson.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    gener_id = json['gener_id'];
    message = json['message'];
    gener_name = json['gener_name'];
  }
}