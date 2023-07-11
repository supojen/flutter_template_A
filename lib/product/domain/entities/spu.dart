
import 'package:equatable/equatable.dart';

class SPU extends Equatable {
  final int id;
  final String name; 
  final String description;

  const SPU({
    required this.id,
    required this.name,
    required this.description
  });
  
  @override
  List<Object?> get props => [id];

}