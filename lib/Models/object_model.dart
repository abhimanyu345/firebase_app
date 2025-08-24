class ObjectModel {
  String id;
  String name;
  Map<String, dynamic> data;

  ObjectModel({required this.id, required this.name, required this.data});

  factory ObjectModel.fromJson(Map<String, dynamic> json) {
    return ObjectModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      data: json['data'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'data': data,
    };
  }
}
