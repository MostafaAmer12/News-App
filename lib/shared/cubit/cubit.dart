import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit():super(AppInitialState());

  int CurrentIndex = 0;

  static AppCubit get(context)=> BlocProvider.of(context);

  void getIndex(index)
  {
    CurrentIndex=index;
    emit(AppBottomNavBarState(index));
  }


  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void ChangeBottomSheetState(
  {
    required bool isShow,
    required IconData icon,
  })
  {
    isBottomSheetShown=isShow;
    fabIcon=icon;

    emit(AppBottomSheetState());
  }

  bool isDark =false;

  void changeAppMode({fromShared})
  {
    isDark=!isDark;
      emit(AppChangeModeState());
  }
}