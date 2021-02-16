class ModelBarberDetails {
  bool status;
  String message;
  BarberDetails barberDetails;

  ModelBarberDetails({this.status, this.message, this.barberDetails});

  ModelBarberDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    barberDetails =
        json['data'] != null ? new BarberDetails.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.barberDetails != null) {
      data['data'] = this.barberDetails.toJson();
    }
    return data;
  }
}

class BarberDetails {
  String sId;
  List<int> workingDays;
  String name;
  int rate;
  String description;
  String createdAt;
  String updatedAt;
  int iV;
  String image;
  List<ServiceId> serviceId;

  BarberDetails(
      {this.sId,
      this.workingDays,
      this.name,
      this.rate,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.image,
      this.serviceId});

  BarberDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    workingDays = json['workingDays'].cast<int>();
    name = json['name'];
    rate = json['rate'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    image = json['image'];
    if (json['service_id'] != null) {
      serviceId = new List<ServiceId>();
      json['service_id'].forEach((v) {
        serviceId.add(new ServiceId.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['workingDays'] = this.workingDays;
    data['name'] = this.name;
    data['rate'] = this.rate;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['image'] = this.image;
    if (this.serviceId != null) {
      data['service_id'] = this.serviceId.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceId {
  String sId;
  String name;
  int duration;
  String createdAt;
  String updatedAt;
  int iV;

  ServiceId(
      {this.sId,
      this.name,
      this.duration,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ServiceId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    duration = json['duration'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['duration'] = this.duration;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
