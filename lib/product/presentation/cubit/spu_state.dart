part of 'spu_cubit.dart';

abstract class SpuState extends Equatable {}


class SpuLoadingState extends SpuState {
  @override
  List<Object?> get props => [];
}

/// <Summary> 
///   Means the SPU is loaded sucessfully, and it is readuy to be displayed.
/// </Summary>
class SpuLoadedState extends SpuState {
  final SPU spu;

  SpuLoadedState({
    required this.spu
  });
  
  @override
  List<Object?> get props => [spu];
}

/// <Summary> 
///   Means the SPU is loaded unsucessfully, and there is a message for hint the user.
/// </Summary>
class SpuErrorState extends SpuState {
  final String message;

  SpuErrorState({
    required this.message
  });
  
  @override
  List<Object?> get props => [message]; 
}