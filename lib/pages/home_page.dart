import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/componets/widgets.dart';
import 'package:news_app/pages/search_page.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {

    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('New App'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  navigateTo(context, SearchPage());
                },
              ),
              IconButton(
                icon: const Icon(Icons.brightness_4_outlined),
                onPressed: ()
                {
                  cubit.changeAppMode();
                },
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.BottomNavBarItem,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
          ),
        );
      },
      listener: (context,state) {},
    );
  }
}
