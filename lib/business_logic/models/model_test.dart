
class TestModel {
  int status;
  String message;
  Data data;

  TestModel({this.status, this.message, this.data});

  TestModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int totalRecords;
  List<Records> records;

  Data({this.totalRecords, this.records});

  Data.fromJson(Map<String, dynamic> json) {
    totalRecords = json['TotalRecords'];
    if (json['Records'] != null) {
      records = new List<Records>();
      json['Records'].forEach((v) {
        records.add(new Records.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TotalRecords'] = this.totalRecords;
    if (this.records != null) {
      data['Records'] = this.records.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Records {
  int id;
  String title;
  String shortDescription;
  int collectedValue;
  int totalValue;
  String startDate;
  String endDate;
  String mainImageURL;

  Records(
      {this.id,
      this.title,
      this.shortDescription,
      this.collectedValue,
      this.totalValue,
      this.startDate,
      this.endDate,
      this.mainImageURL});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['title'];
    shortDescription = json['shortDescription'];
    collectedValue = json['collectedValue'];
    totalValue = json['totalValue'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    mainImageURL = json['mainImageURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['title'] = this.title;
    data['shortDescription'] = this.shortDescription;
    data['collectedValue'] = this.collectedValue;
    data['totalValue'] = this.totalValue;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['mainImageURL'] = this.mainImageURL;
    return data;
  }
}
