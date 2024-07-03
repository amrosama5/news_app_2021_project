import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

import '../componets/widgets.dart';

class BusinessPage extends StatelessWidget
{
  const BusinessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      builder: (context,state)
      {
        var list=NewsCubit.get(context).business;
        return list.isNotEmpty ? BuildListView(list) : const Center(child: CircularProgressIndicator());
      },
      listener: (context,state){

      },
    );
  }
}