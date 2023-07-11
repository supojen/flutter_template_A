import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/injection_container.dart';
import 'package:mobile/product/presentation/cubit/spu_cubit.dart';

import '../widgets/spu_display.dart';

class SPUPage extends StatelessWidget {
  const SPUPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SPU'),
      ),
      body: BlocProvider(
        create: (_) => sl<SpuCubit>(),
        child: body(context),
      ) 
    );
  }




  Widget body(BuildContext context) {
    return Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          BlocBuilder<SpuCubit,SpuState>(
            builder: (context, state) {
              if(state is SpuLoadingState) {
                return const MessageDisplay(
                  message: 'start seraching!'
                );
              }
              else if(state is SpuErrorState) {
                return MessageDisplay(
                  message: state.message,
                );
              }
              else {
                return const SizedBox();
              }
            }
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Column(
            children: [
              Placeholder(
                fallbackHeight: 40,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child:Placeholder(fallbackHeight: 30,)
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child:Placeholder(fallbackHeight: 30,)
                  ),
                ],
              )
            ],
          )
        ],
      );
  }
}

