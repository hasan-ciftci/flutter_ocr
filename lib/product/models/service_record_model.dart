class ServiceRecordModel {
  String licensePlate;
  String location;
  String personalNameSurname;
  String licensePlateImage;
  int id;
  int status;
  String createdOn;
  int createdBy;
  String modifiedOn;
  int modifiedBy;
  String deletedOn;
  int deletedBy;

  ServiceRecordModel(
      {this.licensePlate,
      this.location,
      this.personalNameSurname,
      this.licensePlateImage,
      this.id,
      this.status,
      this.createdOn,
      this.createdBy,
      this.modifiedOn,
      this.modifiedBy,
      this.deletedOn,
      this.deletedBy});

  ServiceRecordModel.fromJson(Map<String, dynamic> json) {
    licensePlate = json['licensePlate'];
    location = json['location'];
    personalNameSurname = json['personalNameSurname'];
    licensePlateImage = json['licensePlateImage'];
    id = json['id'];
    status = json['status'];
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
    modifiedOn = json['modifiedOn'];
    modifiedBy = json['modifiedBy'];
    deletedOn = json['deletedOn'];
    deletedBy = json['deletedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['licensePlate'] = this.licensePlate;
    data['location'] = this.location;
    data['personalNameSurname'] = this.personalNameSurname;
    data['licensePlateImage'] = this.licensePlateImage;
    data['id'] = this.id;
    data['status'] = this.status;
    data['createdOn'] = this.createdOn;
    data['createdBy'] = this.createdBy;
    data['modifiedOn'] = this.modifiedOn;
    data['modifiedBy'] = this.modifiedBy;
    data['deletedOn'] = this.deletedOn;
    data['deletedBy'] = this.deletedBy;
    return data;
  }
}
