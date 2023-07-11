import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/product/domain/handlers/get_spu.dart';

import '../../domain/entities/spu.dart';

part 'spu_state.dart';

class SpuCubit extends Cubit<SpuState> {

  final GetSPUHandler getSPUHandler;

  SpuCubit({
    required this.getSPUHandler
  }) : super(SpuLoadingState());


  Future<void> getSPUById(int id) async {
    // description - 
    final command = GetSPUCommand(id: id);
    // descritpion -
    var response = await getSPUHandler(command);
    // description -
    response.fold(
      (failure) {
        emit(SpuErrorState(message: 'fail to load'));
      }, 
      (spu) {
        emit(SpuLoadedState(spu: spu));
      }
    );
  }

}
