class LocationModel {
  double latitude;
  double longitude;
  double altitude;
  double heading;
  double speed;
  double speedAccuracy;
  DateTime timestamp;
  int floor;
  bool isMocked;

  LocationModel(
      {this.latitude,
      this.longitude,
      this.altitude,
      this.heading,
      this.speed,
      this.speedAccuracy,
      this.timestamp,
      this.floor,
      this.isMocked});

  LocationModel.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    altitude = json['altitude'];
    heading = json['heading'];
    speed = json['speed'];
    speedAccuracy = json['speedAccuracy'];
    timestamp = json['timestamp'];
    floor = json['floor'];
    isMocked = json['isMocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['altitude'] = this.altitude;
    data['heading'] = this.heading;
    data['speed'] = this.speed;
    data['speedAccuracy'] = this.speedAccuracy;
    data['timestamp'] = this.timestamp;
    data['floor'] = this.floor;
    data['isMocked'] = this.isMocked;
    return data;
  }
}
