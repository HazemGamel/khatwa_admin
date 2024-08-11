class DriverLicenseModel {
  String? sId;
  String? vehicleName;
  List<String>? vehicleImages;
  bool? approved;
  String? vehicleLicense;
  String? nationalId;
  String? driverLicense;
  String? criminalRecord;
  List<DriverData>? driverData;

  DriverLicenseModel(
      {this.sId,
        this.vehicleName,
        this.vehicleImages,
        this.approved,
        this.vehicleLicense,
        this.nationalId,
        this.driverLicense,
        this.criminalRecord,
        this.driverData});

  DriverLicenseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    vehicleName = json['vehicle_name'];
    vehicleImages = json['vehicle_images'].cast<String>();
    approved = json['approved'];
    vehicleLicense = json['vehicle_license'];
    nationalId = json['National_id'];
    driverLicense = json['driver_license'];
    criminalRecord = json['criminal_record'];
    if (json['driverData'] != null) {
      driverData = <DriverData>[];
      json['driverData'].forEach((v) {
        driverData!.add(new DriverData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['vehicle_name'] = this.vehicleName;
    data['vehicle_images'] = this.vehicleImages;
    data['approved'] = this.approved;
    data['vehicle_license'] = this.vehicleLicense;
    data['National_id'] = this.nationalId;
    data['driver_license'] = this.driverLicense;
    data['criminal_record'] = this.criminalRecord;
    if (this.driverData != null) {
      data['driverData'] = this.driverData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DriverData {
  String? name;
  int? age;
  String? email;
  String? image;
  String? phone;

  DriverData({this.name, this.age, this.email, this.image, this.phone});

  DriverData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    email = json['email'];
    image = json['image'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    data['email'] = this.email;
    data['image'] = this.image;
    data['phone'] = this.phone;
    return data;
  }
}