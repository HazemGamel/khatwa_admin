class CategoryModel {
  String? sId;
  String? name;
  String? image;
  int? commission;
  int? iV;
  bool? delivery;
  bool? riding;

  CategoryModel(
      {this.sId,
        this.name,
        this.image,
        this.commission,
        this.iV,
        this.delivery,
        this.riding});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    commission = json['commission'];
    iV = json['__v'];
    delivery = json['delivery'];
    riding = json['riding'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['commission'] = this.commission;
    data['__v'] = this.iV;
    data['delivery'] = this.delivery;
    data['riding'] = this.riding;
    return data;
  }
}