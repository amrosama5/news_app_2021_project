import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../componets/widgets.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class SciencePage extends StatelessWidget {
  const SciencePage({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      builder: (context,state)
      {
        var list=NewsCubit.get(context).science;
        return list.isNotEmpty ? BuildListView(list) : const Center(child: CircularProgressIndicator());
      },
      listener: (context,state)
      {

      },
    );
  }
}
