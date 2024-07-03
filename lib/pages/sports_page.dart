import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../componets/widgets.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class SportsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      builder: (context,state)
      {
        var list=NewsCubit.get(context).sport;
        return list.isNotEmpty ? BuildListView(list) : const Center(child: CircularProgressIndicator());
      },
      listener: (context,state){

      },
    );
  }
}
