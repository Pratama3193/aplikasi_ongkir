class Kota{
  String? cityId;
  String? provinceId;
  String? province;
  String? type;
  String? cityName;
  String? postalCode;
  
  Kota(
    {
      this.cityId,
      this.cityName,
      this.provinceId,
      this.postalCode,
      this.province,
      this.type});

  Kota.fromJson(Map<String, dynamic> json){
    cityId = json['city_id'];
    province = json['province'];
    provinceId = json['province_id'];
    type = json['type'];
    cityName = json['city_name'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson(){
    final data = <String, dynamic>{};
    data['city_id'] = cityId;
    data['province_id'] = provinceId;
    data['province'] = province;
    data['type'] = type;
    data['city_name'] = cityName;
    data['postal_code'] = postalCode;
    return data;
  }
  static List<Kota> fromJsonList(List? data) {
    if (data == null || data.length == 0) return [];
    return data.map((e) => Kota.fromJson(e)).toList();
  }

  @override
  String toString() => cityName!;
}