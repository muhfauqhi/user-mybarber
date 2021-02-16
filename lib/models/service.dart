class ModelService {
  bool status;
  String message;
  List<Service> service;

  ModelService({this.status, this.message, this.service});

  ModelService.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      service = new List<Service>();
      json['data'].forEach((v) {
        service.add(new Service.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.service != null) {
      data['data'] = this.service.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Service {
  String sId;
  String name;
  int duration;
  String createdAt;
  String updatedAt;
  int iV;

  Service(
      {this.sId,
      this.name,
      this.duration,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Service.fromJson(Map<String, dynamic> json) {
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
