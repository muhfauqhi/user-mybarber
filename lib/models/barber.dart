class ModelBarber {
  bool status;
  String message;
  List<Barber> barber;

  ModelBarber({this.status, this.message, this.barber});

  ModelBarber.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      barber = new List<Barber>();
      json['data'].forEach((v) {
        barber.add(new Barber.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> barber = new Map<String, dynamic>();
    barber['status'] = this.status;
    barber['message'] = this.message;
    if (this.barber != null) {
      barber['data'] = this.barber.map((v) => v.toJson()).toList();
    }
    return barber;
  }
}

class Barber {
  String image;
  List<int> workingDays;
  List<String> serviceId;
  String sId;
  String name;
  int rate;
  String description;
  String createdAt;
  String updatedAt;
  int iV;
  double rating;

  Barber({
    this.image,
    this.workingDays,
    this.serviceId,
    this.sId,
    this.name,
    this.rate,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.rating,
  });

  Barber.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    workingDays = json['workingDays'].cast<int>();
    serviceId = json['serviceId'].cast<String>();
    sId = json['_id'];
    name = json['name'];
    rate = json['rate'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['workingDays'] = this.workingDays;
    data['serviceId'] = this.serviceId;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['rate'] = this.rate;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
