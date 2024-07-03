import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/states.dart';
import '../componets/widgets.dart';
import '../shared/cubit/cubit.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  var textController = TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children:
            [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 16),
                child: CustomFormField(
                  labelText: 'Search',
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  controller: textController,
                  keyboardType: TextInputType.text,
                  onChanged: (value)
                  {
                    NewsCubit.get(context).getSearchDataFromApi(value);
                  },
//                       onSubmitted: (_) {
//                         NewsCubit.get(context).getSearchDataFromApi(_);
//                         print(list);
//                       },
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              list.isNotEmpty ? Expanded(child: BuildListView(list)) :  Expanded(child: Center(child: Text('Please,Enter what you want to look for',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:NewsCubit.isDark ? Colors.white:Colors.black),))),
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
// Column(
// children: [
// Padding(
// padding: const EdgeInsets.all(16.0),
// child: CustomFormField(
// labelText: 'Search',
// validator: (val) {
// if (val!.isEmpty) {
// return 'search must not be empty';
// }
// return null;
// },
// controller: textController,
// keyboardType: TextInputType.text,
// onChanged: (value) {
// NewsCubit.get(context).getSearchDataFromApi(value);
// },
// //                       onSubmitted: (_) {
// //                         NewsCubit.get(context).getSearchDataFromApi(_);
// //                         print(list);
// //                       },
// prefixIcon: const Icon(Icons.search),
// ),
// ),
// list.isNotEmpty
// ? Expanded(child: BuildListView(list))
// : Center(child: CircularProgressIndicator()),
// ],
// );
