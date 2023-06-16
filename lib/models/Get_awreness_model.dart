/// error : false
/// message : "Awareness Get Successfull"
/// data : [{"id":"1","title":"test","aware_input":"poster","aware_language":"Hindi","date":"2023-06-07 18:04:13","image":"uploads/media/2023/647df12b82c0f.jpg","doctor_id":"365","status":"0","thumbnail":""}]

class GetAwrenessModel {
  GetAwrenessModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetAwrenessModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
GetAwrenessModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetAwrenessModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// title : "test"
/// aware_input : "poster"
/// aware_language : "Hindi"
/// date : "2023-06-07 18:04:13"
/// image : "uploads/media/2023/647df12b82c0f.jpg"
/// doctor_id : "365"
/// status : "0"
/// thumbnail : ""

class Data {
  Data({
      String? id, 
      String? title, 
      String? awareInput, 
      String? awareLanguage, 
      String? date, 
      String? image, 
      String? doctorId, 
      String? status, 
      String? thumbnail,}){
    _id = id;
    _title = title;
    _awareInput = awareInput;
    _awareLanguage = awareLanguage;
    _date = date;
    _image = image;
    _doctorId = doctorId;
    _status = status;
    _thumbnail = thumbnail;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _awareInput = json['aware_input'];
    _awareLanguage = json['aware_language'];
    _date = json['date'];
    _image = json['image'];
    _doctorId = json['doctor_id'];
    _status = json['status'];
    _thumbnail = json['thumbnail'];
  }
  String? _id;
  String? _title;
  String? _awareInput;
  String? _awareLanguage;
  String? _date;
  String? _image;
  String? _doctorId;
  String? _status;
  String? _thumbnail;
Data copyWith({  String? id,
  String? title,
  String? awareInput,
  String? awareLanguage,
  String? date,
  String? image,
  String? doctorId,
  String? status,
  String? thumbnail,
}) => Data(  id: id ?? _id,
  title: title ?? _title,
  awareInput: awareInput ?? _awareInput,
  awareLanguage: awareLanguage ?? _awareLanguage,
  date: date ?? _date,
  image: image ?? _image,
  doctorId: doctorId ?? _doctorId,
  status: status ?? _status,
  thumbnail: thumbnail ?? _thumbnail,
);
  String? get id => _id;
  String? get title => _title;
  String? get awareInput => _awareInput;
  String? get awareLanguage => _awareLanguage;
  String? get date => _date;
  String? get image => _image;
  String? get doctorId => _doctorId;
  String? get status => _status;
  String? get thumbnail => _thumbnail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['aware_input'] = _awareInput;
    map['aware_language'] = _awareLanguage;
    map['date'] = _date;
    map['image'] = _image;
    map['doctor_id'] = _doctorId;
    map['status'] = _status;
    map['thumbnail'] = _thumbnail;
    return map;
  }

}