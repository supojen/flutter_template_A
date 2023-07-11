import 'package:mobile/product/domain/entities/spu.dart';

class SPUModel extends SPU {
  const SPUModel({
    required super.id, 
    required super.name, 
    required super.description
  });
  

  factory SPUModel.fromJson(Map<String, dynamic> json) {
    return SPUModel(
      id: (json['id'] as num).toInt(), 
      name: json['name'], 
      description: json['description']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description
    };
  }
}