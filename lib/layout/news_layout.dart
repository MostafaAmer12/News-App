

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/Newsapp/cubit.dart';
import 'package:news_app/layout/Newsapp/states.dart';
import 'package:news_app/layout/modules/search/search_screen.dart';
import 'package:news_app/shared/cubit/cubit.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context, state) {},
      builder: (context,state) {
        var cubit =NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'News App'
            ),
            actions: [IconButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context){
                            return SearchScreen();
                          }
                      )
                  );
                },
                icon: Icon(Icons.search)
            ),
              IconButton(
                  onPressed: (){
                    AppCubit.get(context).changeAppMode();
                  },
                  icon: Icon(Icons.brightness_4_outlined)
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItems,
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
      );
  }
}
