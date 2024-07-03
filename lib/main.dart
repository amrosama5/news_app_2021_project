import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/pages/home_page.dart';
import 'package:news_app/shared/cubit/bloc_observer.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/shared_preferences.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool?  isDark= CacheHelper.getData(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  const MyApp(this.isDark, {super.key});
  final bool? isDark;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusinessDataFromApi()..changeAppMode(fromShared: isDark),
      child: BlocConsumer<NewsCubit,NewsStates>(
       builder: (context,state)
       {
         return MaterialApp(
           title: 'News App',
           debugShowCheckedModeBanner: false,
           theme: ThemeData(
               scaffoldBackgroundColor: Colors.white,
               primarySwatch: Colors.deepOrange,
               appBarTheme: const AppBarTheme(
                   titleTextStyle: TextStyle(
                       color: Colors.black,
                       fontSize: 23,
                       fontWeight: FontWeight.bold
                   ),
                   iconTheme: IconThemeData(
                       color: Colors.black,
                       size: 30
                   ),
                   backgroundColor: Colors.white,
                   systemOverlayStyle: SystemUiOverlayStyle(
                       statusBarIconBrightness: Brightness.dark,
                       statusBarColor: Colors.white
                   ),
                   elevation: 1
               ),
               bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                 type: BottomNavigationBarType.fixed,
                 selectedItemColor: Colors.deepOrange,
                 unselectedItemColor: Colors.black,
                 elevation: 10,
               )
           ),
           darkTheme: ThemeData(
               scaffoldBackgroundColor: const Color(0xff333739),
               primarySwatch: Colors.deepOrange,
               appBarTheme: const AppBarTheme(
                   titleTextStyle: TextStyle(
                       color: Colors.white,
                       fontSize: 23,
                       fontWeight: FontWeight.bold
                   ),
                   iconTheme: IconThemeData(
                       color: Colors.white,
                       size: 30
                   ),
                   backgroundColor: Color(0xff333739),
                   systemOverlayStyle: SystemUiOverlayStyle(
                       statusBarIconBrightness: Brightness.light,
                       statusBarColor:  Color(0xff333739)
                   ),
                   elevation: 1
               ),
               bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                 type: BottomNavigationBarType.fixed,
                 selectedItemColor: Colors.deepOrange,
                 unselectedItemColor: Colors.grey,
                 elevation: 10,
                 backgroundColor:  Color(0xff333739)
               ),
           ),
           themeMode: NewsCubit.isDark ? ThemeMode.dark : ThemeMode.light,
           home: const MyHomePage(),
         );
       },
       listener: (context,state) {},
      ),
    );
  }
}
