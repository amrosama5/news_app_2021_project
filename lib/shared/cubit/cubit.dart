import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/pages/business_page.dart';
import 'package:news_app/pages/science_page.dart';
import 'package:news_app/pages/sports_page.dart';
import 'package:news_app/shared/network/local/shared_preferences.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());
  ///Objects
  static NewsCubit get(context) => BlocProvider.of(context);


  ///BottomNavigationBar
  int currentIndex=0;
  List<BottomNavigationBarItem> BottomNavBarItem =const [
    BottomNavigationBarItem(icon: Icon(Icons.business),label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports),label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science),label: 'Science'),
  ];
  void changeBottomNavBar(index)
  {
    currentIndex = index;
    emit(NewsChangeNavBarItem());
    if(index==1){
      getSportDataFromApi();
    }else if(index==2){
      getScienceDataFromApi();
    }
  }
  List<Widget> screens=[const BusinessPage(),SportsPage(),const SciencePage()];

  /// Api dio helper
  List business=[];
  List sport=[];
  List science=[];
  List<dynamic> search=[];


  void getBusinessDataFromApi()
  {
    emit(NewsLoadingBusinessData());
    if(business.isEmpty)
    {
      DioHelper.getData(
          url: '/v2/top-headlines' ,
          query: {
            'country':'eg',
            'category':'business',
            'apikey':'c28d341053524926a18a4ac0b17f6942'
          }
      ).then((value)
      {
        business = value.data['articles'];
        emit(NewsGetBusinessSuccessData());
      }).catchError((ex)
      {
            emit(NewsGetBusinessErrorData());
            print(ex.toString());
      });
    }else{
      emit(NewsGetBusinessSuccessData());
    }

  }
  void getSportDataFromApi()
  {
    emit(NewsLoadingSportData());
    if(sport.isEmpty)
    {

      DioHelper.getData(
          url: '/v2/top-headlines' ,
          query: {
            'country':'eg',
            'category':'sport',
            'apikey':'5fd535b884a94611830c18fc03ec2b46'
          }
      ).then((value)
      {
        sport = value.data['articles'];
        emit(NewsGetSportSuccessData());
      }).catchError((ex)
      {
        emit(NewsGetSportErrorData());
        print(ex.toString());
      });
    }else{
      emit(NewsGetSportSuccessData());
    }

  }
  void getScienceDataFromApi()
  {
    emit(NewsLoadingScienceData());
    if(science.isEmpty)
    {
      DioHelper.getData(
          url: '/v2/top-headlines' ,
          query: {
            'country':'eg',
            'category':'science',
            'apikey':'5fd535b884a94611830c18fc03ec2b46'
          }
      ).then((value)
      {
        science = value.data['articles'];
        emit(NewsGetScienceSuccessData());
      }).catchError((ex)
      {
        emit(NewsGetScienceErrorData());
        print(ex.toString());
      });
    }else{
      emit(NewsGetScienceSuccessData());
    }

  }

  void getSearchDataFromApi(String value)
  {
    emit(NewsLoadingSearchData());
    DioHelper.getData(
        url: '/v2/everything' ,
        query: {
          'q':value,
          'apikey':'ff4def1d62a54452b70265668bf7c233'
        }
    ).then((value)
    {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessData());
      print(search[0]['title']);
    }).catchError((ex)
    {
      print(ex.toString());
      emit(NewsGetSearchErrorData());
    });
  }

  /// change App mode light or dark
  static bool isDark=false;
  void changeAppMode({bool? fromShared})
  {
    if(fromShared != null) {
       isDark = fromShared ;
       emit(NewsChangeAppMode());
    }else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(NewsChangeAppMode());
      });
    }
  }



}