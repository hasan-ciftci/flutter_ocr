class LocationModel {
  double latitude;
  double longitude;
  double altitude;
  double heading;
  double speed;
  double speedAccuracy;
  int floor;
  int isMocked;

  LocationModel(
      {this.latitude,
      this.longitude,
      this.altitude,
      this.heading,
      this.speed,
      this.speedAccuracy,
      this.floor,
      this.isMocked});

  LocationModel.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    altitude = json['altitude'];
    heading = json['heading'];
    speed = json['speed'];
    speedAccuracy = json['speedAccuracy'];
    floor = json['floor'];
    isMocked = json['isMocked'] == true ? 1 : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['altitude'] = this.altitude;
    data['heading'] = this.heading;
    data['speed'] = this.speed;
    data['speedAccuracy'] = this.speedAccuracy;
    data['floor'] = this.floor;
    data['isMocked'] = this.isMocked;
    return data;
  }
}
