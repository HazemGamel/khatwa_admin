class ReelsModel {
  String? sId;
  String? url;
  String? createdAt;
  String? expiresAt;
  int? iV;

  ReelsModel({this.sId, this.url, this.createdAt, this.expiresAt, this.iV});

  ReelsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    url = json['url'];
    createdAt = json['createdAt'];
    expiresAt = json['expiresAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['url'] = this.url;
    data['createdAt'] = this.createdAt;
    data['expiresAt'] = this.expiresAt;
    data['__v'] = this.iV;
    return data;
  }
}