class PaginationMetaData {
  int totalCount;
  int page;
  int limit;

  PaginationMetaData({this.totalCount, this.page, this.limit});

  PaginationMetaData.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    page = json['page'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    data['page'] = this.page;
    data['limit'] = this.limit;
    return data;
  }
}
