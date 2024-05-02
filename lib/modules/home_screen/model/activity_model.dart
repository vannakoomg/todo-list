class ActivityModel {
  String? checkOutDate;
  String? todoDate;
  String? checkInDate;
  String? remark;
  String? photoLat;
  String? photoLong;
  bool? hasOrder;
  String? photo;

  ActivityModel(
      {this.checkOutDate,
      this.todoDate,
      this.checkInDate,
      this.remark,
      this.photoLat,
      this.photoLong,
      this.hasOrder,
      this.photo});

  ActivityModel.fromJson(Map<String, dynamic> json) {
    checkOutDate = json['check_out_date'];
    todoDate = json['todo_date'];
    checkInDate = json['check_in_date'];
    remark = json['remark'];
    photoLat = json['photo_lat'];
    photoLong = json['photo_long'];
    hasOrder = json['has_order'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['check_out_date'] = checkOutDate;
    data['todo_date'] = todoDate;
    data['check_in_date'] = checkInDate;
    data['remark'] = remark;
    data['photo_lat'] = photoLat;
    data['photo_long'] = photoLong;
    data['has_order'] = hasOrder;
    data['photo'] = photo;
    return data;
  }
}
