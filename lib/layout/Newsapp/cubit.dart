

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/Newsapp/states.dart';
import 'package:news_app/layout/modules/business/business_screen.dart';
import 'package:news_app/layout/modules/science/science_screen.dart';
import 'package:news_app/layout/modules/sports/sports_screen.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit(): super(NewsInitialState());

  static NewsCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;

  List <BottomNavigationBarItem> bottomItems=
  [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports_baseball_sharp,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];
  List <Widget> screens =
  [
    BusniessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  void changeBottomNavBar(int index)
  {
    currentIndex =index;
    if (index ==1)
      getSports();
    if(index==2)
      getScience();
    emit(NewsBottomNavState());
  }
  List<dynamic> business=[];
  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url:'v2/everything',
        query:{
          'domains':'wsj.com',
          'apiKey':'f9402e07f87d49afa4f31acc5a520043',
        }
    ).then((value)
    {
      business=value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports=[];
  void getSports()
  {
    emit(NewsGetSportsLoadingState());
    if (sports.length==0)
      {
        DioHelper.getData(url: 'v2/everything',
            query:{
              'sources':'techcrunch',
              'apiKey':'f9402e07f87d49afa4f31acc5a520043',
            }
        ).then((value)
        {
          //print(value.data.toString());
          sports=value.data['articles'];
          print(sports[0]['title']);
          emit(NewsGetSportsSuccessState());
        }).catchError((error)
        {
          print(error.toString());
          emit(NewsGetSportsErrorState(error.toString()));
        });
      }
    else
      {
        emit(NewsGetSportsSuccessState());
      }

  }

  List<dynamic> science=[];
  void getScience()
  {
    emit(NewsGetScienceLoadingState());
    if(science.length==0)
      {
        DioHelper.getData(url: 'v2/everything',
            query:{
              'q':'apple',
              'from':'2022-08-18',
              'to':'2022-08-18',
              'sortBy':'popularity',
              'apiKey':'f9402e07f87d49afa4f31acc5a520043',
            }
        ).then((value)
        {
          //print(value.data.toString());
          science=value.data['articles'];
          print(science[0]['title']);
          emit(NewsGetScienceSuccessState());
        }).catchError((error)
        {
          print(error.toString());
          emit(NewsGetScienceErrorState(error.toString()));
        });
      }
    else
      {
        emit(NewsGetScienceSuccessState());
      }
  }

  List<dynamic> search=[];
  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());

      DioHelper.getData(
          url: 'v2/everything',
          query:{
            'q':'$value',
            'from':'2022-08-21',
            'apiKey':'f9402e07f87d49afa4f31acc5a520043',
          }
      ).then((value)
      {
        //print(value.data.toString());
        search=value.data['articles'];

        print(search[0]['title']);

        emit(NewsGetSearchSuccessState());
      }).catchError((error)
      {
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString()));
      });
  }

}